{root}: {
    config,
    flakePath,
    inputs,
    isThinClient,
    username,
    ...
}: helpers:
root
// helpers
// {
    mkRelativePath = root.mkRelativePath inputs.self;
    mkSymlink = root.mkSymlink {
        inherit (inputs) self;
        inherit isThinClient flakePath;
        hmConfig = config.home-manager.users.${username};
    };
}
