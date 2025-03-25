{
    lib,
    username,
    ...
}: {
    # host specific configuration

    modules = {
        bootable.enable = true;
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

    users.users.${username}.description = lib.capitalize username;
    programs.git.package = (lib.getNixpkgs "nixpkgs").git-fire;

    hm.home.file."test.txt" = lib.mkSymlink ./test.txt;
}
