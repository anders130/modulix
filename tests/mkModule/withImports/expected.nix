{modulix}: {
    imports = [./file.nix];
    options.example.enable = modulix.internal.enableOptionResult "example";
    config = {
        _type = "if";
        condition = true;
        content = {};
    };
}
