{modulix, ...}: {
    imports = [./other.nix];
    options.example.enable = modulix.internal.enableOptionResult "example";
    config = {
        _type = "if";
        condition = true;
        content = {};
    };
}
