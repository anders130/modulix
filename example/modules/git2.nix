{
    lib,
    pkgs,
    ...
}: {
    options = {
        userEmail = lib.mkOption {
            type = lib.types.str;
            default = "user@example.com";
        };
        userName = lib.mkOption {
            type = lib.types.str;
            default = "User Name";
        };
    };

    config = cfg: {
        hm.programs.git = {
            inherit (cfg) userEmail userName;
            enable = true;
            package = pkgs.git;
        };
    };
}
