{modulix}: {
    imports = [];
    options.foo.bar.enable = modulix.internal.enableOptionResult "bar";
    config = {
        _type = "if";
        condition = true;
        content.foo.bar = 1;
    };
}
