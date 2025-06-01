{modulix}: [
    {
        config = {
            condition = true;
            content.foo.bar = 2;
        };
        imports = [];
        options.module.enable = modulix.internal.enableOptionResult "module";
    }
]
