{modulix}: modulix.mkHosts {
    inputs.self = ./__fixture;
}
|> builtins.attrNames
