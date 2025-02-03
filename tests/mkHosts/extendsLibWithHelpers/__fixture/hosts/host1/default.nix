{lib, username, ...}: {
    users.users.${username} = {
        isNormalUser = true;
        name = username;
        description = lib.getUsername;
    };
}
