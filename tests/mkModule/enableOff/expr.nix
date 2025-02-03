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
        config.foo.bar = 1;
    };
in modulix.mkModule hostArgs false ./example module
    |> modulix.internal.cleanupModule
