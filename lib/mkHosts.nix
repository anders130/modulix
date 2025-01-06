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
                helpers' = if isAttrs helpers then helpers else helpers args;
                args' = args // {lib = lib.configure args helpers';};
            in {
                imports = [
                    (internalName
                        |> hostPath
                        |> import
                        |> (c: if isAttrs c then c else c args')
                    )
                    sharedConfig
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
        |> (c: if builtins.isAttrs c then c else c inputs)
        |> (c: {
            inherit name;
            value = mkHost name c;
        })
    )
    |> listToAttrs
