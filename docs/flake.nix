{
    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
        flake-parts.url = "github:hercules-ci/flake-parts";
    };

    outputs = inputs: inputs.flake-parts.lib.mkFlake {inherit inputs;} {
        systems = ["x86_64-linux"];
        perSystem = {pkgs, ...}: {
            devShells.default = pkgs.mkShell {
                packages = [pkgs.mdbook];
                shellHook = ''
                    toplevel=$(git rev-parse --show-toplevel) || exit
                    cd "$toplevel" || exit
                    mdbook serve docs
                '';
            };

            packages.default = pkgs.stdenv.mkDerivation {
                pname = "modulix-docs";
                version = inputs.self.shortRev or "0000000";
                src = ../.;
                nativeBuildInputs = [pkgs.mdbook];
                buildPhase = ''
                    cd docs
                    mdbook build -d $out
                '';
            };
        };
    };
}
