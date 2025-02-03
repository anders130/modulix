{
    root,
    lib,
}: {
    config,
    flakePath,
    inputs,
    isThinClient,
    username,
    ...
}: helpers:
lib # nixos
// root # modulix
// helpers # user defined stuff
// { # better modulix
    mkRelativePath = root.mkRelativePath inputs.self;
    mkSymlink = root.mkSymlink {
        inherit (inputs) self;
        inherit isThinClient flakePath;
        hmConfig = config.home-manager.users.${username};
    };
}
