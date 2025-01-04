{lib, ...}: {
    options.someOption = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Some option";
    };

    config = cfg: {
        # some config
    };
}
