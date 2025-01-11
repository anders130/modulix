{...}: {
    path,
    fileName,
    args,
}: let
    inherit (builtins) attrNames filter isFunction readDir;
in path
    |> readDir
    |> attrNames
    |> filter (x: x != "expected.nix" && x != "expr.nix")
    |> map (x:
        "${path}/${x}/${fileName}"
        |> import
        |> (c: if isFunction c then c args else c)
    )

