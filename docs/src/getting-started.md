# Getting Started

## Installation

To use **modulix**, you first need to enable the following **experimental Nix features**:

```conf
experimental-features = nix-command flakes pipe-operators
```

Then add **modulix** to your flake inputs:

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

    ...
}
```

> While overriding the `nixpkgs` and `home-manager` inputs is not required, it's recommended for consistency across your configuration.

## Using `mkHosts`

Once **modulix** is included in your flake, you can use the `mkHosts` function to define your hosts:

`flake.nix`:

```nix
{
    ...

    outputs = inputs: {
        nixosConfigurations = inputs.modulix.lib.mkHosts {
            inherit inputs;
            src = ./hosts; # optional (defaults to ./hosts)
            flakePath = "/path/to/flake"; # optional (for lib.mkSymlink)
            modulesPath = ./modules; # optional
            specialArgs = {
                hostname = "nixos";
                # put in your specialArgs like above
            };
        };
    };
}
```

The `mkHosts` function will assume a directory structure like this:

```
.
├── hosts
│   ├── host1
│   │   ├── config.nix  # special args for the host
│   │   └── default.nix # the configuration for the host
│   └── host2
│       ├── config.nix
│       └── default.nix
├── modules
│   ├── module1.nix
│   └── module2.nix
└── flake.nix
```

Each host has:

- A `config.nix` → Defines values for the **specialArgs** defined in the `mkHosts` function.
- A `default.nix` → The **configuration** for the host.

You can switch to a specific host using:

```bash
nixos-rebuild switch --flake .#host1
```

### Special arguments (`specialArgs`)

The `specialArgs` attribute in `mkHosts` allows you to define arguments that are passed to all files. These arguments provide default values that can be overridden by each host's `config.nix` file.

For example:

```nix
mkHosts {
    ...
    specialArgs = {
        argument1 = "value1";
        argument2 = "value2";
    };
}
```

This defines `argument1` and `argument2` as special arguments with their respective default values. If the `config.nix` file of a host provides a different value, it will override the default.

### `config.nix`

Each host has a `config.nix` file, which can either be:

1. A **set** defining configuration values.
2. A **function** that takes the flake's **inputs** and returns a **set**.

The configuration set can include:

```nix
{
    isThinClient = false; # if true, lib.mkSymlink will use the store path instead of the flake path
    system = "x86_64-linux"; # the system of the host
    username = "nixos"; # the username of the host
    modules = []; # additional modules to add to the host
}
```

Additionally, `config.nix` can override the `specialArgs` values defined in `mkHosts`.

Example `config.nix` (as a function):

```nix
inputs: {
    system = "x86_64-linux";
    username = "user1";
    hostname = "host1";
    modules = [inputs.some-module.nixosModules.some-module];
}
```

## Modules

The modules directory contains files that define your reusable configurations (modules). The directory structure determines how modules are loaded:

```
modules
├── module1.nix
├── module2
│   ├── submodule1.nix
│   └── submodule2.nix
└── category
    └── module3.nix
```

This structure results in the following configuration format:

```nix
{
    modules = {
        module1.enable = true;
        module2 = {
            submodule1.enable = true;
            submodule2.enable = true;
        };
        category.module3.enable = true;
    };
}
```

### How Modules Work

- Each module's configuration requires the `enable` option to be set to `true` to be enabled.
- The `enable` option is created automatically if it doesn't exist.
- Multi-file modules (`default.nix` inside a directory) are loaded as a single module when enabled.

### Writing Modules

#### Basic Module Example

A simple module that enables a service:

`modules/simple.nix`

```nix
{
    services.foo.enable = true;
}
```

#### Defining Custom Options

Modules can define their own **options**:

```nix
{
    options.foo = lib.mkOption {
        type = lib.types.str;
        default = "bar";
    };
    config = cfg: {
        services.foo.name = cfg.foo;
    };
}
```

> The `cfg` argument contains the module's **options**, making them available inside `config`.

#### Importing external modules

Modules can also import other modules. This is useful, when you want to use options from another input:

```nix
{inputs, ...}: {
    imports = [inputs.some-module.nixosModules.some-module];

    options = { ... };

    config = { ... };
}
```

#### Multi-file modules

Modules can span multiple files. A directory containing a `default.nix` is treated as a multi-file module:

```
modules
├── module1.nix
└── module2
    ├── default.nix
    ├── extra.nix
    └── extra2.nix
```

- If `module2` is enabled, **all nix code in the `module2` directory** will be loaded.
- Each file can define its own options and config, and all options remain available in `cfg`.

Check out the [example](https://github.com/anders130/modulix/tree/master/example) directory to see it in action.
