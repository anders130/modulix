# modulix

A library for creating modularized nixos configurations, built upon [haumea](https://github.com/nix-community/haumea).

Please have a look at [lib](./lib) for more information about the library functions.

## Usage

To use this library, you need to have enabled the following experimental features:

```conf
experimental-features = nix-command flakes pipe-operators
```

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
        nixosConfigurations = inputs.modulix.lib.mkHosts {
            inherit inputs;
            path = ./hosts-directory; # optional
            flakePath = "/path/to/flake"; # for lib.mkSymlink
            modulesPath = ./modules-directory; # optional
            specialArgs = {
                hostname = "nixos";
                # put in your specialArgs like above
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
│ ├── config.nix
│ └── default.nix
└── host2
  ├── config.nix
  └── default.nix

```

example `config.nix`:

```nix
inputs: {
    system = "x86_64-linux";
    username = "user1";
    hostname = "host1";
    modules = [
        inputs.some-module.nixosModules.some-module
    ];
}
```

**default specialArgs**

The default specialArgs are:

```nix
{
    isThinClient = false; # if true, lib.mkSymlink will use the store path instead of the flake path
    system = "x86_64-linux"; # the system of the host
    username = "nixos"; # the username of the host
    modules = []; # additional modules to add to the host
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

## Contributing

Contributions are welcome!

## License

[MIT](./LICENSE)
