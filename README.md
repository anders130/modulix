# modulix

A library for creating modularized nixos configurations.

## Usage

Look at the [example](./example) directory for a working example.

`flake.nix`:

```nix
{
    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
        home-manager = {
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        modulix = {
            url = "github:anders130/modulix";
            inputs.nixpkgs.follows = "nixpkgs";
            inputs.home-manager.follows = "home-manager";
        };
    };

    outputs = inputs: {
        nixosConfigurations = inputs.modulix.lib.mkHosts {inherit inputs;} {
            path = ./hosts-directory;
            modulesPath = ./modules-directory;
            specialArgs = {
                username = "defaultuser";
                # put in your specialArgs
            };
        };
    };
}
```

### `hosts`-directory

The `hosts`-directory should contain a directory for each host you want to configure. The directory name will be the hostname of the host.
The host directory should contain a `default.nix` and a `config.nix`. The `default.nix` should contain the configuration for the host. The `config.nix` should contain the values for the specialArgs.

```
hosts
├── host1
│   ├── config.nix
│   └── default.nix
└── host2
    ├── config.nix
    └── default.nix
```

example `config.nix`:

```nix
inputs: {
    system = "x86_64-linux";
    username = "defaultuser";
    hostname = "host1";
    modules = [
        inputs.some-module.nixosModules.some-module
    ];
}
```

### `modules`-directory

The `modules`-directory should contain a directory or a file for each module you want to declare.

You can declare simple to complex modules:

```nix
{
    options = {
        someOption = mkOption {
            type = types.bool;
            default = false;
            description = "Some option";
        };
    };

    config = cfg: {
        someConfig = cfg.someOption;
    };
}
```

TODO: describe how to declare every possible version of a module.

## Development

TODO: explain library functions

## Contributing

Contributions are welcome!

## License

[MIT](./LICENSE)
