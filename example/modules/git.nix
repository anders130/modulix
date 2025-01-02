{
    gitCredentials,
    pkgs,
    ...
}: {
    hm.programs.git = {
        inherit (gitCredentials) userEmail userName;
        enable = true;
        package = pkgs.git;
    };
}
