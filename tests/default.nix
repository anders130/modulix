{
    self,
    nixpkgs,
    haumea,
    ...
}: let
    inherit (builtins) attrNames filter foldl' readDir;
    loadTests = src:
        haumea.lib.loadEvalTests {
            inherit src;
            inputs = {
                inherit (nixpkgs) lib;
                modulix = self.lib;
            };
        };
in ./.
    |> readDir
    |> attrNames
    |> filter (x: x != "default.nix")
    |> foldl' (_: name: loadTests ./${name}) {}
