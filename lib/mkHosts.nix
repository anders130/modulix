{lib, ...}: {
    inputs,
    flakePath ? null,
    path ? null,
    modulesPath ? null,
    specialArgs ? {},
    sharedConfig ? {},
}: let
    inherit (builtins) attrNames filter listToAttrs pathExists readDir;
    inherit (lib) mkModules nixosSystem;

    path' =
        if path == null
        then "${inputs.self}/hosts"
        else path;

    hostPath = sub: "${path'}/${sub}";

    mkHost = name: internalConfig @ {
        isThinClient ? false,
        modules ? [],
        system ? "x86_64-linux",
        ...
    }: nixosSystem {
            inherit system;
            # don't remove pkgs because otherwise args doesn't have it
            modules = modules ++ [(args @ {pkgs, ...}: let
                args' = args // {lib = lib.configure args;};
            in {
                imports = [
                    (import (hostPath name) args')
                    sharedConfig
                ] ++ (
                    if modulesPath == null then []
                    else (mkModules args' modulesPath).imports
                );
            }
            )];
            specialArgs = specialArgs // internalConfig // {
                inherit internalConfig inputs isThinClient flakePath;
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
