{lib, ...}: {
    options.something.enable = lib.mkEnableOption "something";
    config = cfg: {
        deep.foo2.bar = cfg.something.enable;
    };
}
