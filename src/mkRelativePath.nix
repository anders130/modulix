{...}: root: path: let
    inherit (builtins) substring stringLength;
    p = toString path;
    rootLen = stringLength (toString root);
in
    substring
    (rootLen + 1)
    (stringLength p - rootLen - 1)
    p

