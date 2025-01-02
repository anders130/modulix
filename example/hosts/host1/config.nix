inputs: {
    hostname = "nixos-host1";
    username = "user1";
    modules = with inputs; [
        # extra nixosModules only needed for this host
    ];
}
