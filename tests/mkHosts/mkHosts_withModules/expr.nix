{modulix}: (modulix.mkHosts {
    inputs.self = ./__fixture;
    modulesPath = ./__fixture/modules;
}).host1.config
|> (x: {
    programs.git.enable = x.programs.git.enable;
    modules.module1.enable = x.modules.module1.enable;
})
# |> builtins.attrNames
