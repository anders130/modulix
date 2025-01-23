{
    haumea,
    lib,
    root
}: {
    inputs,
    flakePath ? null,
    helpers ? {},
    modulesPath ? null,
    path ? "${inputs.self}/hosts",
    sharedConfig ? {},
    specialArgs ? {},
}: let
    inherit (builtins) attrNames concatStringsSep elem filter isAttrs mapAttrs;
    inherit (lib) nixosSystem;
    inherit (root.internal) configure mkModules;

    mkHost = let
        resolve = args: f: if isAttrs f then f else f args;

        defaultArgs = {
            isThinClient = false;
            modules = [];
            system = "x86_64-linux";
            username = "nixos";
        } // specialArgs;

        validateConfig = name: config: config
            |> attrNames
            |> filter (key: !(elem key (attrNames defaultArgs)))
            |> (attrs: if attrs == [] then config
                else throw ''
                    Host configuration "${name}" is trying to define additional attributes:
                    ${
                        attrs
                        |> map (attr: "  - ${attr}")
                        |> concatStringsSep "\n"
                    }
                ''
            );
    in (internalName: value: value.config
        |> import
        |> resolve inputs
        |> validateConfig internalName
        |> (c: defaultArgs // c)
        |> (c: nixosSystem {
            inherit (c) system;
            specialArgs = specialArgs // c // {
                inherit flakePath inputs internalName;
                inherit (c) isThinClient username;
            };
            modules = c.modules ++ [(args @ {pkgs, ...}: let
                helpers' = resolve args helpers;
                args' = args // {lib = configure args helpers';};
            in {
                imports = [
                    (value.default
                        |> import
                        |> resolve args'
                    )
                    (resolve args' sharedConfig)
                ] ++ (
                    if modulesPath == null then []
                    else mkModules args' modulesPath
                );
            })];
        })
    );
in
    mapAttrs mkHost (haumea.load {
        src = path;
        loader = haumea.loaders.path;
    })
