{modulix}: modulix.mkHosts {
    inputs.self = ./.;
}
|> builtins.attrNames
