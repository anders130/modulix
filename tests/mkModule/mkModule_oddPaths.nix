{
    modulix,
    lib,
}: let
    hostArgs = {
        inherit lib;
        inputs.self = ./.;
        config = {
            example.enable = true;
            path.to = {
                folder.enable = true;
                file.enable = true;
            };
        };
    };
    module = {
        config.foo.bar = 1;
    };
    createModule = path: modulix.mkModule hostArgs true path module
        |> modulix.internal.cleanupModule
        |> (x: builtins.removeAttrs x ["imports" "config"]);
in {
    expr = [
        (createModule ./example) # single
        (createModule ./path/to/folder) # deep
        (createModule ./path/to/file.nix) # deep with nix file extension
    ];
    expected = let
        inherit (modulix.internal) enableOptionResult;
    in [
        {
            options.example.enable = enableOptionResult "example";
        }
        {
            options.path.to.folder.enable = enableOptionResult "folder";
        }
        {
            options.path.to.file.enable = enableOptionResult "file";
        }
    ];
}
