{modulix}: {
    imports = [];
    options.example = {
        enable = modulix.internal.enableOptionResult "example";
        foo.bar = {
            default = 1;
            type = "int";
        };
    };
    config = {
        _type = "if";
        condition = true;
        content.foo.bar = 0;
    };
}
