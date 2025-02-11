{lib}: {
    args = {
        inputs.self = ./.;
        isThinClient = false;
        pkgs.runCommandLocal = name: _: command: {inherit name command;};
    };

    process = result: let
        path = result.source.command
            |> lib.strings.splitString " "
            |> (l: builtins.elemAt l 2)
            |> lib.strings.removePrefix (toString ./.)
            ;
    in {
        inherit (result) recursive;
        source = {
            inherit path;
            inherit (result.source) name;
        };
    };
}
