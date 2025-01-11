{
    description = "nix configuration library";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
        home-manager = {
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        haumea = {
            url = "github:nix-community/haumea/v0.2.2";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = {
        self,
        nixpkgs,
        haumea,
        ...
    }: {
        checks = haumea.lib.loadEvalTests {
            src = ./tests;
            inputs = {
                inherit (nixpkgs) lib;
                modulix = self.lib;
            };
        };
        lib = haumea.lib.load {
            src = ./src;
            inputs = {
                inherit (nixpkgs) lib;
            };
        };
    };
}
