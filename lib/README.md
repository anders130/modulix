# `lib`

modulix library functions.

## `configure`

This function is primarily used internally to configure the library functions to ease the usage of those functions.

```nix
lib' = lib.configure args helpers;
```

- `args`: the arguments passed to each file
- `helpers`: additional function that should be added to the library

## `mkHosts`

This function is used to create a set of nixosConfigurations.

It takes the following arguments:

| argument       | description                                | default   |
| -------------- | ------------------------------------------ | --------- |
| `inputs`       | inputs of the flake                        |           |
| `flakePath`    | full path to the flake as string           | `null`    |
| `helpers`      | additional functions to add to the library | `{}`      |
| `modulesPath`  | path to the modules directory              | `null`    |
| `path`         | path to the hosts directory                | `./hosts` |
| `sharedConfig` | shared configuration for all hosts         | `{}`      |
| `specialArgs`  | special arguments for all hosts            | `{}`      |

## `mkModule`

Used internally to create a module by the `mkModules` function.

- `hostArgs`: the arguments passed to each file, including `pkgs`
- `createEnableOption`: whether to create an `enable` option for the module
- `path`: the path to the module
- `args`: contents of the modules file. This can contain imports, options and config attributes but does not have to.

Specifically, this function creates the following set:

```nix
{
    imports = [...];
    options.path.to.module = {
        enable = mkEnableOption "module name";
        ...
    };
    config = mkIf cfg.enable {
        ...
    };
}
```

## `mkModules`

Used internally to create a set of modules by the `mkHosts` function.

- `hostArgs`: the arguments passed to each file, including `pkgs`
- `modulesPath`: path to the modules directory

Specifically, this function creates the following set:

```nix
{
    imports = [
        module1
        module2
        ...
    ];
}
```

## `mkRelativePath`

This function is used to get the relative path of a file from a given root path.

```nix
lib.mkRelativePath root path
```

- `root`: the root path.
- `path`: the path to get the relative path of

> Note: `root` must be a store path to the flake directory. Example: `inputs.self`.

When configured, the root path will be already set to the flake path. It can be used like this:

```nix
lib.mkRelativePath ./path/to/file
# returns "path/to/file"
```

## `mkSymlink`

This function is used to create a symlink.

Specifically, this function creates the following set:

```nix
{
    recursive = true;
    source = <drv>;
}
```

Arguments:

- set of the following arguments:
  - `self`: the flake path
  - `flakePath`: the flake path
  - `hmConfig`: the home-manager config
  - `isThinClient`: whether the store path should be used instead of the flake path
- path: the path to the file you want to symlink

When configured, the set will be already set and you can use it like this:

```nix
hm.home.file."test.txt" = lib.mkSymlink ./path/to/test.txt;
```
