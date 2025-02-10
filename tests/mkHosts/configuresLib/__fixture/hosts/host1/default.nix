{lib, ...}: {
    options.testFile = {
        source = lib.mkOption {
            type = lib.types.package;
        };
        recursive = lib.mkOption {
            type = lib.types.bool;
        };
    };
    config.testFile = lib.mkSymlink ./test.txt;
}
