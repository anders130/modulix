{
    modulix,
    lib,
}: let
    hostArgs = {
        inherit lib;
        config.example.enable = true;
        inputs.self = ./.;
    };
    module.imports = [./other.nix];
in
    modulix.mkModule hostArgs true ./example module
    |> (x: {
        inherit (x) config imports;
        options = modulix.internal.adjustTypeArgs x.options;
    })

