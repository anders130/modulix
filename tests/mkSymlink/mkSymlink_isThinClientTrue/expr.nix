{lib, modulix}: let
    args = {
        self = ./.;
        flakePath = "/home/user1/project";
        isThinClient = true;
        hmConfig.lib.file.mkOutOfStoreSymlink = p: p; # mock for testing
    };
in modulix.mkSymlink args ./example
|> (x: x // {
    # remove the self path from the source for comparison in expected.nix
    source = lib.strings.removePrefix (toString args.self) x.source;
})