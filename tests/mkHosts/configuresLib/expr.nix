{home-manager, modulix}: modulix.mkHosts {
    inputs.self = ./__fixture;
    flakePath = "/home/user1/project";
    sharedConfig = {
        imports = [home-manager.nixosModules.home-manager];
        users.users.nixos.isNormalUser = true;
        home-manager.users.nixos.home.stateVersion = "24.11";
    };
}
|> builtins.mapAttrs (_: y:
    y.config.home-manager.users.nixos.home.file."test.txt"
    |> (x: x // {
        source = x.source.type;
    })
)
