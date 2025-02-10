{lib, root}: hostArgs: path: let
    inherit (hostArgs) flakePath isThinClient pkgs;
    inherit (hostArgs.inputs) self;
    inherit (lib) escapeShellArg lowerChars stringToCharacters upperChars;
    inherit (builtins) genList length replaceStrings warn;

    basePath = let
        s = toString self;
    in
        if isThinClient
        then s
        else if flakePath != null
        then flakePath
        else warn "mkSymlink: flakePath not set, defaulting to self" s;

    # home-manager's mkOutOfStoreSymlink
    mkOutOfStoreSymlink = path: let
        storeFileName = path: let
            # All characters that are considered safe. Note "-" is not
            # included to avoid "-" followed by digit being interpreted as a
            # version.
            safeChars =
                ["+" "." "_" "?" "="]
                ++ lowerChars
                ++ upperChars
                ++ stringToCharacters "0123456789";

            empties = l: genList (x: "") (length l);

            unsafeInName = stringToCharacters (replaceStrings safeChars (empties safeChars) path);

            safeName = replaceStrings unsafeInName (empties unsafeInName) path;
        in
            "hm_" + safeName;

        pathStr = toString path;
        name = storeFileName (baseNameOf pathStr);
    in
        pkgs.runCommandLocal name {} ''ln -s ${escapeShellArg pathStr} $out'';
in {
    recursive = true; # important for directories but has no effect on files
    source = mkOutOfStoreSymlink "${basePath}/${root.mkRelativePath self path}";
}
