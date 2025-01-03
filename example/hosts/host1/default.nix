{lib, ...}: {
    # host specific configuration

    modules = {
        fish.enable = true;
        git.enable = true;
        home-manager.enable = true;
    };

    system.stateVersion = "24.11";

    hm.home.file."test.txt" = lib.mkSymlink ./test.txt;
}
