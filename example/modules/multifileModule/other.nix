{lib, ...}: {
    options.otherOption = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "other option";
    };

    config = cfg: {
        hm.programs.git.enable = cfg.someOption && cfg.otherOption;
    };
}
