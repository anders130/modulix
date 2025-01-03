{lib, ...}: {
    programs.fish = {
        enable = true;
        interactiveShellInit = /*fish*/''
            source $HOME/.config/fish/extraConfig.fish
        '';
    };

    hm.xdg.configFile."fish/extraConfig.fish" = lib.mkSymlink ./config.fish;
}
