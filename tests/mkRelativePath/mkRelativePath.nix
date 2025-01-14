{modulix}: let
    inherit (modulix) mkRelativePath;
in {
    name = "mkRelativePath";
    expr = [
        (mkRelativePath ./. ./.) # empty
        (mkRelativePath ./. ./example) # single
        (mkRelativePath ./. ./path/to/file) # deep
        (mkRelativePath ./path ./path/to/file) # deep with different root
    ];
    expected = [
        ""
        "example"
        "path/to/file"
        "to/file"
    ];
}
