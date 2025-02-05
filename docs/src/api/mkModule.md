# `mkModule`

Source: [`src/mkModule.nix`](https://github.com/anders130/modulix/blob/master/src/mkModule.nix)

Type: `(hostArgs : { ... }) -> (createEnableOption : Bool) -> (path : Path) -> (args : { ... }) -> { ... }`

Arguments:

- `hostArgs` : `{ ... }`

  the arguments passed to each file, including `pkgs`

- `createEnableOption` : `Bool`

  whether to create an `enable` option for the module

- `path` : `Path`

  the path to the module

- `args` : `{ ... }`

  contents of the modules file. This can contain imports, options and config attributes but does not have to.

Result:

The function returns a set with the following attributes:

- `imports` : `[ ... ]`

  the imports of the module

- `options` : `{ ... }`

  the options of the module

- `config` : `{ ... }`

  the config of the module

The result will look like this:

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
