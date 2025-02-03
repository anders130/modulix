{
    haumea,
    lib,
}: args: let
    inherit (builtins) attrNames foldl' isAttrs;
    inherit (lib) generators runTests;

    flatten = prefix: set:
        foldl' (
            acc: key: let
                value = set.${key};
                newKey =
                    if prefix == ""
                    then key
                    else "${prefix}/${key}";
            in
                if isAttrs value && value ? expected && value ? expr
                then acc // {${newKey} = value;}
                else acc // flatten newKey set.${key}
        ) {} (attrNames set);

    tests = flatten "" (haumea.load args);

    results = runTests (tests
        // {
            tests = attrNames tests;
        });
in
    assert tests
    ? tests
    -> "'tests' cannot be used as a test name";
    assert results
    != []
    -> throw (generators.toPretty {} results); {}
