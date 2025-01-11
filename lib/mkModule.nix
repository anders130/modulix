{lib, ...}: hostArgs: createEnableOption: path: {
    imports ? [],
    options ? {},
    config ? null,
    ...
} @ args: let
    inherit (builtins) elemAt isAttrs length;
    inherit (lib) foldr mkIf mkRelativePath removeSuffix splitString;

    hostConfig = hostArgs.config;

    pathList = path
        |> mkRelativePath hostArgs.inputs.self # relative path to the configs flake root
        |> removeSuffix ".nix"
        |> removeSuffix "/default" # if path is a default.nix, remove it
        |> splitString "/";

    cfg = lib.foldl' (obj: key: obj.${key}) hostConfig pathList; # get the modules option values from the hostConfig

    adjustConfig = config: config
        |> (c: removeAttrs c ["imports"]);
in {
    imports = imports ++ config.imports or [];
    options = options
        |> (o:
            if createEnableOption
            then o // {enable = lib.mkEnableOption (elemAt pathList (length pathList - 1));}
            else o
        )
        |> (o: foldr (key: acc: {${key} = acc;}) o pathList); # set the value at the path
    config = config
        |> (c: if c != null then c
            else if options != {} then {} else args
        ) # if config is not set and options are set, assume args are the config
        |> (c: if isAttrs c then c else (c cfg)) # if config is a function, call it with cfg
        |> adjustConfig
        |> mkIf cfg.enable; # only enable if cfg.enable is true
}
