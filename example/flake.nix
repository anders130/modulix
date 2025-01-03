{
    description = "example dotfiles";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-24.11";
        home-manager = {
            url = "github:nix-community/home-manager?ref=release-24.11";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        modulix = {
            # url = "github:anders130/modulix";
            url = "path:/home/jesse/Projects/modulix";
            inputs.nixpkgs.follows = "nixpkgs";
            inputs.home-manager.follows = "home-manager";
        };
    };

    outputs = inputs: {
        nixosConfigurations = inputs.modulix.lib.mkHosts {
            inherit inputs;
            modulesPath = ./modules;
            specialArgs = {
                hostname = "nixos";
                username = "defaultuser";
                gitCredentials = {
                    userEmail = "email@example.com";
                    userName = "User Name";
                };
            };
        };
    };
}
