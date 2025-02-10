{
    modulix,
    root,
}: let
    inherit (root.mkSymlink.deps) args process;
    args' = args // {flakePath = "/home/user1/project";};
in
    modulix.mkSymlink args' ./example
    |> process
