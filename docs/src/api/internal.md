# `internal`

Internal functions used primarily for testing.

## `internal.adjustTypeArgs`

Source: [`src/internal/adjustTypeArgs.nix`](https://github.com/anders130/modulix/blob/master/src/internal/adjustTypeArgs.nix)

Type: `{ ... } -> { ... }`

Removes the `type` and `_type` attributes from the given set to prevent infinite recursion.

## `internal.cleanupModule`

Source: [`src/internal/cleanupModule.nix`](https://github.com/anders130/modulix/blob/master/src/internal/cleanupModule.nix)

Type: `{ ... } -> { (imports : [ ... ]); (options : { ... }); (config : { ... }); }`

uses `internal.adjustTypeArgs` to adjust a module in tests.

## `internal.configure`

Source: [`src/internal/configure.nix`](https://github.com/anders130/modulix/blob/master/src/internal/configure.nix)

Type: `(hostArgs : { ... }) -> (helpers : { ... }) -> { ... }`

Arguments:

- `hostArgs` : `{ ... }`

  the arguments passed to each file, including `pkgs`

- `helpers` : `{ ... }`

  helper functions given by the user to extend the `lib` set

Result:

The function returns an extended `lib` set with all the functions of modulix, the nixpkgs `lib` and the user's helpers.

## `internal.enableOptionResult`

Source: [`src/internal/enableOptionResult.nix`](https://github.com/anders130/modulix/blob/master/src/internal/enableOptionResult.nix)

Type: `(moduleName : String) -> { ... }`

Simplifies comparison of the `enable` option of a module. Used in tests.

## `internal.mkModules`

Source: [`src/internal/mkModules.nix`](https://github.com/anders130/modulix/blob/master/src/internal/mkModules.nix)

Type: `(hostArgs : { ... }) -> (path : Path) -> [ ... ]`

Arguments:

- `hostArgs` : `{ ... }`

  the arguments passed to each file, including `pkgs`

- `path` : `Path`

  path to the modules directory

Result:

A list of modules.

```nix
{
    imports = [
        module1
        module2
        ...
    ];
}
```

Used by [`mkHosts`](./mkHosts.md) and [`mkModule`](./mkModule.md) to create modules.
