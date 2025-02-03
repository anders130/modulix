{modulix}: {
    expr = modulix.mkModules ./modules
        |> map (m: {
            isFunction = builtins.isFunction m;
            args = builtins.functionArgs m;
            result.hasImportsAttr = builtins.hasAttr "imports" (m {pkgs = false;});
        });

    expected = [
        {
            isFunction = true;
            args.pkgs = false;
            result.hasImportsAttr = true;
        }
    ];
}
