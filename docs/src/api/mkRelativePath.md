# `mkRelativePath`

Source: [`src/mkRelativePath.nix`](https://github.com/anders130/modulix/blob/master/src/mkRelativePath.nix)

Type: `(root : Path) -> (path : Path) -> String`

Arguments:

- `root` : `Path`

  the root path.<br>
  Example: `inputs.self`

- `path` : `Path`

  the path to get the relative path of (relative to `root`)

Result:

This function is used to get the relative path of a file from a given root path.

```nix
mkRelativePath ./. ./path/to/file
# returns "path/to/file"
```
