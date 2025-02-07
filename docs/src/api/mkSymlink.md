# `mkSymlink`

Source: [`src/mkSymlink.nix`](https://github.com/anders130/modulix/blob/master/src/mkSymlink.nix)

Type: `(args : { ... }) -> Path -> { ... }`

Arguments:

- `args` : `{ ... }`

  This must contain the following attributes:

  - `self` : `Path`

    the flake path

  - `flakePath` : `String`

    the flake path as absolute path

  - `hmConfig` : `{ ... }`

    the home-manager config of the current user

  - `isThinClient` : `Bool`

    whether the store path should be used instead of the flake path

- `path` : `Path`

  the path to the file you want to symlink

Result:

This function is used to create a symlink.

Specifically, this function creates the following set:

```nix
{
    recursive = true;
    source = <drv>;
}
```

## Usage inside files managed by `mkHosts`:

This function is configured by the `mkHosts` function to be used in a more convenient way:

```nix
mkSymlink ./path/to/file
```
