# `mkHosts`

Source: [`src/mkHosts.nix`](https://github.com/anders130/modulix/blob/master/src/mkHosts.nix)

Type: `{ inputs, src?, flakePath?, helpers?, modulesPath?, specialArgs?, sharedConfig? } -> { ... }`

Arguments:

- `inputs` : `{ ... }`

  Inputs of the flake. Must contain `self` and `nixpkgs`.

- (optional) `src` : `Path`

  Path to the hosts directory. Defaults to `./hosts`.

- (optional) `flakePath` : `String`

  Full path to the flake as string. Defaults to `null`.

- (optional) `helpers` : `{ ... } | args: { ... }`

  Additional functions to add to the library. Can be a function or a set of functions. If it is a function, it will be called with the arguments passed to each file to make functions be able to use configuration values. If it is just a set of functions, they will just be added to the `lib`.
  Defaults to `{}`.

  Example:

  ```nix
  helpers = args: {
      getUsername = "got ${args.username}";
  };
  ```

- (optional) `modulesPath` : `Path`

  Path to the modules directory. Defaults to `null`.
  If set, the `mkModules` function will be used to create the modules.

- (optional) `specialArgs` : `{ ... }`

  Special arguments for all hosts. Defaults to `{}`.
  These arguments will be passed to each file and can be overridden by the `config.nix` file of each host.

- (optional) `sharedConfig` : `{ ... } | args: { ... }`

  Shared configuration for all hosts (accepts args). Defaults to `{}`.
  Can be a function or a set of functions. If it is a function, it will be called with the arguments passed to each file to make functions be able to use configuration values.
