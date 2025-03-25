{
    haumea,
    lib,
    root
}: {
    inputs,
    flakePath ? null,
    helpers ? {},
    modulesPath ? null,
    src ? "${inputs.self}/hosts",
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
    in (internalName: value: value
        |> (v: if v ? config then import v.config else {})
        |> resolve inputs
        |> validateConfig internalName
        |> (c: defaultArgs // c)
        |> (c: nixosSystem {
            inherit (c) system;
            specialArgs = specialArgs // c // {
                inherit flakePath inputs internalName;
                inherit (c) isThinClient;
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
        inherit src;
        loader = haumea.loaders.path;
    })
