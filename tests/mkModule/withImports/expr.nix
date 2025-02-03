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
        imports = [./file.nix];
    };
in modulix.mkModule hostArgs true ./example module
    |> modulix.internal.cleanupModule
