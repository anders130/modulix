{
    modulix,
    root,
}: let
    inherit (root.mkSymlink.deps) args process;
    args' = args // {
        flakePath = "/home/user1/project";
        isThinClient = true;
    };
in
    modulix.mkSymlink args' ./example
    |> process
