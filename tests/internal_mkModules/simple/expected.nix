{modulix}: [
    {
        config = {
            condition = true;
            content.foo.bar = 1;
        };
        imports = [];
        options.module.enable = modulix.internal.enableOptionResult "module";
    }
]
