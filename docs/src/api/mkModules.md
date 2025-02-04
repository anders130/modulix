# `mkModules`

Source: [`src/mkModules.nix`](https://github.com/anders130/modulix/blob/master/src/mkModules.nix)

Type: `(path : Path) -> [ (args : { ... }) -> { ... } ]`

Arguments:

- `path` : `Path`

  the path to the modules directory

Result:

The function returns a list containing one function that takes the arguments passed to each file and returns a set with the following attributes:

```nix
{
    imports = [
        module1
        module2
        ...
    ];
}
```

The modules are created by the [`mkModule`](./mkModule.md) function.
