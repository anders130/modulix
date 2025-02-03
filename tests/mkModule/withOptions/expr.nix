{
    modulix,
    lib,
}: let
    hostArgs = {
        inherit lib;
        inputs.self = ./.;
        config.example = {
            enable = true;
            foo.bar = 0;
        };
    };
    module = {
        options.foo.bar = lib.mkOption {
            type = lib.types.int;
            default = 1;
        };
        config = cfg: {
            foo.bar = cfg.foo.bar;
        };
    };
in modulix.mkModule hostArgs true ./example module
    |> modulix.internal.cleanupModule
