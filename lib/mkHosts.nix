{inputs, lib}: args: {
    path,
    modulesPath ? null,
    specialArgs ? {},
}: let
    inherit (builtins) attrNames filter listToAttrs pathExists readDir;
    inherit (lib) mkModules nixosSystem;

    hostPath = sub: path + "/${sub}";

    mkHost = name: internalConfig @ {
        modules ? [],
        system ? "x86_64-linux",
        ...
    }:
        nixosSystem {
            inherit system;
            modules = modules ++ [
                (hostPath name) # relative path to the hosts default.nix
                (args' @ {pkgs, ...}: let
                    fixedArgs = args' // {inherit pkgs;};
                in
                    if modulesPath != null then mkModules fixedArgs modulesPath else {}
                )
            ];
            specialArgs = specialArgs // internalConfig // {
                inherit internalConfig;
                inherit (args) inputs;
            };
        };

    getConfigs = path: path
        |> readDir
        |> attrNames # get all dir names
        |> filter (name: pathExists (hostPath "${name}/config.nix"))
        |> map (name: (hostPath "${name}/config.nix")
            |> import
            |> (c: if builtins.isAttrs c then c else c inputs)
            |> (c: {
                inherit name;
                value = mkHost name c;
            })
        )
        |> listToAttrs;

in getConfigs path
