{
    # host specific configuration

    modules = {
        bootable.enable = true;
        home-manager.enable = true;
        git2 = {
            enable = true;
            userEmail = "user2@example.com";
            userName = "User Name 2";
        };
    };

    system.stateVersion = "24.11";
}
