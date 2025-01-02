inputs: let
    inherit (builtins) attrNames filter listToAttrs map readDir replaceStrings;
in ./.
    |> readDir
    |> attrNames # only get the names of the files
    |> filter (name: name != "default.nix") # skip itself
    |> map (name: {
        name = replaceStrings [".nix"] [""] name;
        value = import ./${name} inputs;
    })
    |> listToAttrs
