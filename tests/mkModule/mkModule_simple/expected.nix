{
    imports = [./other.nix];
    options.example = {
        enable = {
            default = false;
            description = "Whether to enable example.";
            example = true;
            type = "bool";
        };
        foo.bar = {
            default = 1;
            type = "int";
        };
    };
    config = {
        _type = "if";
        condition = true;
        content.foo.bar = 1;
    };
}
