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

    outputs = inputs: {
        checks = import ./tests inputs;
        lib = inputs.haumea.lib.load {
            src = ./src;
            inputs = {
                inherit (inputs.nixpkgs) lib;
                haumea = inputs.haumea.lib;
            };
        };
    };
}
