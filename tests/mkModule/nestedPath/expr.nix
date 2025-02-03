{
    modulix,
    lib,
}: let
    hostArgs = {
        inherit lib;
        inputs.self = ./.;
        config.foo.bar.enable = true;
    };
    module = {
        config.foo.bar = 1;
    };
in modulix.mkModule hostArgs true ./foo/bar module
    |> modulix.internal.cleanupModule
