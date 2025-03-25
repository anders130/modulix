{username, ...}: {
    fileSystems."/" = {
        device = "/dev/disk/by-label/nixos";
        fsType = "ext4";
    };
    boot.loader.systemd-boot.enable = true;

    users.users.${username}.isNormalUser = true;
}
