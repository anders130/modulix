{modulix}: (modulix.mkHosts {
    inputs.self = ./.;
    specialArgs.testArg = true;
})
    |> builtins.mapAttrs (_: y:
        builtins.tryEval (y._module) # throw is hidden inside _module
        |> (r: {inherit (r) success;})
    )

