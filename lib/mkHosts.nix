{lib, ...}: {
    inputs,
    flakePath ? null,
    helpers ? {},
    modulesPath ? null,
    path ? null,
    sharedConfig ? {},
    specialArgs ? {},
}: let
    inherit (builtins) attrNames filter isAttrs listToAttrs pathExists readDir;
    inherit (lib) mkModules nixosSystem;

    resolve = args: f: if isAttrs f then f else f args;

    path' =
        if path == null
        then "${inputs.self}/hosts"
        else path;

    hostPath = sub: "${path'}/${sub}";

    mkHost = internalName: internalConfig @ {
        isThinClient ? false,
        modules ? [],
        system ? "x86_64-linux",
        username ? "nixos",
        ...
    }: nixosSystem {
            inherit system;
            # don't remove pkgs because otherwise args doesn't have it
            modules = modules ++ [(args @ {pkgs, ...}: let
                helpers' = resolve args helpers;
                args' = args // {lib = lib.configure args helpers';};
            in {
                imports = [
                    (internalName
                        |> hostPath
                        |> import
                        |> resolve args'
                    )
                    (resolve args' sharedConfig)
                ] ++ (
                    if modulesPath == null then []
                    else (mkModules args' modulesPath).imports
                );
            })];
            specialArgs = specialArgs // internalConfig // {
                inherit internalName inputs isThinClient flakePath username;
            };
        };

in path'
    |> readDir
    |> attrNames # get all dir names
    |> filter (name: pathExists (hostPath "${name}/config.nix"))
    |> map (name: (hostPath "${name}/config.nix")
        |> import
        |> resolve inputs
        |> (c: {
            inherit name;
            value = mkHost name c;
        })
    )
    |> listToAttrs
