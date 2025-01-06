{lib, ...}: {
    self,
    flakePath,
    hmConfig,
    isThinClient,
}: path: let
    basePath = let s = toString self; in
        if isThinClient then s
        else if flakePath != null then flakePath
        else builtins.warn "mkSymlink: flakePath not set, defaulting to self" s;
in {
    recursive = true; # important for directories but has no effect on files
    source = path
        |> lib.mkRelativePath self
        |> (p: "${basePath}/${p}")
        |> hmConfig.lib.file.mkOutOfStoreSymlink;
}
