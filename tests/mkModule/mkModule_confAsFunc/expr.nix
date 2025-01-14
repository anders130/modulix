{
    modulix,
    lib,
}: let
    hostArgs = {
        inherit lib;
        inputs.self = ./.;
        config = {
            example.enable = true;
            foo.bar = true;
        };
    };
    module = {
        config = cfg: {
            foo.bar = !cfg.enable;
        };
    };
in modulix.mkModule hostArgs true ./example module
    |> modulix.internal.cleanupModule
