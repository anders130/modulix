{
    modulix,
    lib,
}: let
    hostArgs = {
        inherit lib;
        inputs.self = ./.;
        config.example.enable = true;
    };
    module = {
        foo.bar = 1;
    };
in modulix.mkModule hostArgs true ./example module
    |> modulix.internal.cleanupModule
