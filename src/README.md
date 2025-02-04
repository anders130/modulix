# `src`-modulix

modulix library functions.

## `internal`-functions

Internal functions used by the library.

### `adjustTypeArgs`

This function is used to remove the `type` argument from the options to make them testable.

### `cleanupModule`

This function wraps the `adjustTypeArgs` function to easily use it in tests.

### `configure`

This function is primarily used internally to configure the library functions to ease the usage of those functions.

```nix
lib' = lib.configure args helpers;
```

- `args`: the arguments passed to each file
- `helpers`: additional function that should be added to the library

### `enableOptionResult`

This function returns a enable option with the given name and description.

### `mkModules`

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
