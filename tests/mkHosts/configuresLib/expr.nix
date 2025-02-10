{modulix}: modulix.mkHosts {
    inputs.self = ./__fixture;
    flakePath = "/home/user1/project";
}
|> builtins.mapAttrs (_: y:
    y.config.testFile
    |> (x: x // {
        source = x.source.type;
    })
)
