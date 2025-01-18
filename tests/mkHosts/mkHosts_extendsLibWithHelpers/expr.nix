{modulix}: (modulix.mkHosts {
    inputs.self = ./.;
    helpers = args: {
        getUsername = "got ${args.username}";
    };
}).host1.config
|> (x: {
    inherit (x.users.users.nixos) isNormalUser name description;
})
