{
    modulix,
    root
}: let
    inherit (root.mkSymlink.deps) args process;
    args' = args // {flakePath = null;};
in
    modulix.mkSymlink args' ./example
    |> process
