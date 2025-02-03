{lib, ...}: {
    home-manager.users.nixos.home.file."test.txt" = lib.mkSymlink ./test.txt;
}
