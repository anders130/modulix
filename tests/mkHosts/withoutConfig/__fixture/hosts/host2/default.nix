{
    lib,
    testArg,
    ...
}: {
    options.otherArg = lib.mkOption {
        type = lib.types.bool;
    };
    config.otherArg = testArg;
}
