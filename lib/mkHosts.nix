inputs: {
    path,
    specialArgs ? {},
}: let
    inherit (builtins) attrNames filter listToAttrs pathExists readDir;

    hostPath = sub: path + "/${sub}";

    mkHost = name: internalConfig @ {
        modules ? [],
        system ? "x86_64-linux",
        ...
    }:
        inputs.nixpkgs.lib.nixosSystem {
            inherit system;
            modules = modules ++ [
                (hostPath name) # relative path to the hosts default.nix
            ];
            specialArgs = specialArgs // internalConfig // {
                inherit inputs internalConfig;
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
