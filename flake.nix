{
    description = "nix configuration library";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
        haumea = {
            url = "github:nix-community/haumea/v0.2.2";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = inputs: {
        checks = inputs.self.lib.recursiveLoadEvalTests {
            src = ./tests;
            inputs = {
                inherit (inputs.nixpkgs) lib;
                modulix = inputs.self.lib;
            };
        };
        lib = inputs.haumea.lib.load {
            src = ./src;
            inputs = {
                inherit inputs;
                inherit (inputs.nixpkgs) lib;
                haumea = inputs.haumea.lib;
            };
        };
    };
}
