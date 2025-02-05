# `recursiveLoadEvalTests`

Source: [`src/recursiveLoadEvalTests.nix`](https://github.com/anders130/modulix/blob/master/src/recursiveLoadEvalTests.nix)

Type: `{ src, inputs? } -> {}`

Arguments:

- `src` : `Path`

  the path to the directory containing the tests

- (optional) `inputs` : `{ ... }`

  inputs passed into each test to make functions available

Result:

This function is used to load and evaluate tests from a directory (much like [`haumea.lib.loadEvalTests`](https://github.com/nix-community/haumea/blob/master/src/lib.nix#L10)). But it will flatten the directory structure to allow for nested directories and add them to the tests name for easier debugging.
