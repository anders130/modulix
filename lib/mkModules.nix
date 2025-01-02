{lib, ...}: args: path: let
    inherit (builtins) any attrValues baseNameOf concatMap dirOf filter groupBy head isAttrs;
    inherit (lib) mkModule;
    inherit (lib.lists) flatten;

    importModule = file: file
        |> import
        |> (m: if isAttrs m then m else m args);

    getFiles = dir: dir
        |> lib.filesystem.listFilesRecursive # list all files in the directory
        |> filter (n: lib.strings.hasSuffix ".nix" n) # only nix files
        |> filter (n: n != ./default.nix) # filter out this file
        |> groupBy (file: toString (dirOf file))
        |> attrValues
        # if there is a default.nix file, then spread the files into the list
        |> concatMap (files:
            if any (file: baseNameOf file == "default.nix") files
            then [files]
            else map (file: [file]) files
        );

    getMainFile = files:
        if any (file: baseNameOf file == "default.nix") files
        then filter (file: baseNameOf file == "default.nix") files
        else files;

    mkModules = files: let
        mainFile = head (getMainFile files);
    in
        map (file: file
            |> importModule
            # create the module with the name of the file
            # only declare an enalbe option if the file is the main file
            |> mkModule args (file == mainFile) mainFile
        ) files;
in {
    imports = path
        |> getFiles
        |> map mkModules # return a list of modules
        |> flatten; # bring all modules into one list
}
