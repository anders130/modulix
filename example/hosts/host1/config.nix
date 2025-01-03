inputs: {
    hostname = "nixos-host1";
    username = "jesse";
    modules = with inputs; [
        # extra nixosModules only needed for this host
    ];
}
