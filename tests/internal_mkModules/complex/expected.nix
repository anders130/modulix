{modulix}: [
    {
        config = {
            condition = true;
            content.foo1.bar = 1;
        };
        imports = [];
        options.module1.enable = modulix.internal.enableOptionResult "module1";
    }

    {
        config = {
            condition = true;
            content.foo2.bar = 1;
        };
        imports = [];
        options.module2.enable = modulix.internal.enableOptionResult "module2";
    }

    {
        config = {
            condition = true;
            content.deep.foo1.bar = 1;
        };
        imports = [];
        options.deeper.laying.module1.enable = modulix.internal.enableOptionResult "module1";
    }


    {
        config = {
            condition = true;
            content.deep.foo2.bar = true;
        };
        imports = [];
        options.deeper.laying.module2 = {
            enable = modulix.internal.enableOptionResult "module2";
            something.enable = modulix.internal.enableOptionResult "something";
        };
    }

    {
        config = {
            condition = true;
            content.deep.foo3.bar = 1;
        };
        imports = [];
        options.deeper.laying.module3.enable = modulix.internal.enableOptionResult "module3";
    }

    {
        config = {
            condition = true;
            content.deep.foo4.bar = 1;
        };
        imports = [];
        options.deeper.laying.module4.enable = modulix.internal.enableOptionResult "module4";
    }
    {
        config = {
            condition = true;
            content.deep.foo4.baz = 1;
        };
        imports = [];
        options.deeper.laying.module4 = {};
    }
]
