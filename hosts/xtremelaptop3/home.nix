{ config, pkgs, inputs, lib, ... }:
{
    imports = [
        ./../../modules/git.nix
	./../../modules/zsh.nix
        ./../../modules/tmux.nix
        ./../../variables.nix
    ];

    home.username = "xtremejames1";
    home.homeDirectory = "/home/xtremejames1";

# This value determines the Home Manager release that your configuration is
# compatible with. This helps avoid breakage when a new Home Manager release
# introduces backwards incompatible changes.
#
# You should not change this value, even if you update Home Manager. If you do
# want to update the value, then make sure to first check the Home Manager
# release notes.
    home.stateVersion = "23.11"; # Please read the comment before changing.

    home.packages = with pkgs; [
        neovim
        clang
        fastfetch
        libqalculate
        calcurse
        aichat
        feh
    ];

# Home Manager is pretty good at managing dotfiles. The primary way to manage
# plain files is through 'home.file'.

    home.file = {
        ".config/nvim" = {
            recursive = true;
            source = config.dotfiles.directory+"/.config/nvim";
        };
        ".config/vivaldi-stable.conf".text = "--password-store=gnome-libsecret";
    };

# CUSTOM MODULE OPTIONS
    programs.zsh.shellAliases.vimhome = lib.mkForce "nvim ~/nixos/hosts/xtremelaptop3/home.nix";
    programs.zsh.shellAliases.vimconfig = lib.mkForce "nvim ~/nixos/hosts/xtremelaptop3/configuration.nix";

    home.sessionVariables = {
        EDITOR = "neovim";
        NIXHOST = "xtremelaptop3";
    };

# Let Home Manager install and manage itself.
    programs.home-manager.enable = true;
}
