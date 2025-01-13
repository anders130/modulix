{modulix, ...}: {
    imports = [];
    options.example.enable = modulix.internal.enableOptionResult "example";
    config = {
        _type = "if";
        condition = true;
        content.foo.bar = 1;
    };
}
