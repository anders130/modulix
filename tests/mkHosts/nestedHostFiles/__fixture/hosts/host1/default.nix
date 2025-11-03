{lib, ...}: {
    options.myTestOption = lib.mkOption {
        type = lib.types.str;
        default = "world";
    };
}
