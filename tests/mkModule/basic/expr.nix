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
in modulix.mkModule hostArgs true ./example module
    |> (x: {
        inherit (x) config imports;
        options = modulix.internal.adjustTypeArgs x.options;
    })
