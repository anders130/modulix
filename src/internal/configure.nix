{
    root,
    lib,
}: hostArgs: helpers:
lib # nixos
// root # modulix
// helpers # user defined stuff
// { # better modulix
    mkRelativePath = root.mkRelativePath hostArgs.inputs.self;
    mkSymlink = root.mkSymlink hostArgs;
}
