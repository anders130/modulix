{lib, ...}: {
    self,
    flakePath,
    hmConfig,
    isThinClient,
}: path: let
    basePath =
        if isThinClient
        then "${self}"
        else toString flakePath;
in {
    recursive = true; # important for directories but has no effect on files
    source = path
        |> lib.mkRelativePath self
        |> (p: "${basePath}/${p}")
        |> (p: lib.debug.traceSeq {inherit p;} p)
        |> hmConfig.lib.file.mkOutOfStoreSymlink;
}
