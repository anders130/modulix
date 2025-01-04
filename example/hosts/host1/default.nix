{lib, ...}: {
    # host specific configuration

    modules = {
        category.subcategory.module1.enable = true;
        fish.enable = true;
        multifileModule = {
            enable = true;
            someOption = true;
            otherOption = true;
        };
        git.enable = true;
    };

    system.stateVersion = "24.11";

    hm.home.file."test.txt" = lib.mkSymlink ./test.txt;
}
