{
    modulix,
    lib,
}: let
    hostArgs = {
        inherit lib;
        config.example = {
            enable = true;
            foo.bar = 1;
        };
        inputs.self = ./.;
    };
    module = {
        imports = [./other.nix];
        options.foo.bar = lib.mkOption {
            type = lib.types.int;
            default = 1;
        };
        config = cfg: {
            foo.bar = cfg.foo.bar;
        };
    };
in
    modulix.mkModule hostArgs true ./example module
    |> (x: {
        inherit (x) config imports;
        options = modulix.internal.adjustTypeArgs x.options;
    })

