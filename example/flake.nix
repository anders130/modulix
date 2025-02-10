{
    description = "example dotfiles";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-24.11";
        home-manager = {
            url = "github:nix-community/home-manager?ref=release-24.11";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        modulix = {
            url = "path:../.";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = inputs: {
        nixosConfigurations = inputs.modulix.lib.mkHosts {
            inherit inputs;
            flakePath = "/home/jesse/Projects/modulix/example";
            modulesPath = ./modules;
            helpers = import ./lib;
            specialArgs = {
                hostname = "nixos";
                username = "defaultuser";
                gitCredentials = {
                    userEmail = "email@example.com";
                    userName = "User Name";
                };
            };
            sharedConfig = {hostname, ...}: {
                modules.home-manager.enable = true;
                networking.hostName = hostname;
            };
        };
    };
}
