{lib, ...}: {
    inputs,
    path ? null,
    modulesPath ? null,
    specialArgs ? {},
}: let
    inherit (builtins) attrNames filter listToAttrs pathExists readDir;
    inherit (lib) mkModules nixosSystem;

    flakePath = sub: "${inputs.self}/${sub}";
    path' = if path == null then flakePath "hosts" else path;
    hostPath = sub: "${path'}/${sub}";

    mkHost = name: internalConfig @ {
        modules ? [],
        system ? "x86_64-linux",
        ...
    }:
        nixosSystem {
            inherit system;
            modules = modules ++ [
                (hostPath name) # relative path to the hosts default.nix
                (args @ {pkgs, ...}: let
                    fixedArgs = args // {inherit pkgs;};
                in
                    if modulesPath == null then {}
                    else mkModules fixedArgs modulesPath
                )
            ];
            specialArgs = specialArgs // internalConfig // {
                inherit internalConfig inputs;
            };
        };

in path'
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
    |> listToAttrs
