{modulix}: (modulix.mkHosts {
    inputs.self = ./__fixture;
    specialArgs.testArg = true;
})
|> (x: {
    host1.config.otherArg = x.host1.config.otherArg;
    host2.config.otherArg = x.host2.config.otherArg;
})
