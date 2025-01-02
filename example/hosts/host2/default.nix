{
    # host specific configuration

    modules = {
        home-manager.enable = true;
        git2 = {
            enable = true;
            userEmail = "user2@example.com";
            userName = "User Name 2";
        };
    };
}
