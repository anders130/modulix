{
    lib,
    modulix,
}: modulix.internal.loadSubtests {
    path = ./.;
    fileName = "expected.nix";
    args = {inherit lib modulix;};
}
