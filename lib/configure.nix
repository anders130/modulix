{lib, ...}: {
    config,
    flakePath,
    inputs,
    isThinClient,
    username,
    ...
}: helpers:
lib
// helpers
// {
    mkRelativePath = lib.mkRelativePath inputs.self;
    mkSymlink = lib.mkSymlink {
        inherit (inputs) self;
        inherit isThinClient flakePath;
        hmConfig = config.home-manager.users.${username};
    };
}
