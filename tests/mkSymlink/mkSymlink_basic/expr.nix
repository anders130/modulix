{modulix}: let
    args = {
        self = ./.;
        flakePath = "/home/user1/project";
        isThinClient = false;
        hmConfig.lib.file.mkOutOfStoreSymlink = p: p; # mock for testing
    };
in modulix.mkSymlink args ./example
