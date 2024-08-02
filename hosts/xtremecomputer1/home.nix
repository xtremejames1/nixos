{ config, pkgs, inputs, lib, ... }:
{
    imports = [
        ./../../modules/browser.nix
        ./../../modules/terminal.nix
        ./../../modules/git.nix
        ./../../modules/music.nix
        ./../../modules/calendar.nix
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
        zed-editor
        orca-slicer
        fastfetch
        betterdiscordctl
        gcalcli
        recoll
        libqalculate
        calcurse
        aichat
        feh
        perl
        perl536Packages.Appcpanminus
        azure-cli
        azure-cli-extensions.image-copy-extension
        python312Packages.pip
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
    wayland.windowManager.hyprland.settings.monitor = lib.mkForce ["HDMI-A-1,1920x1080,0x0,auto,transform,0" "DP-3,1360x768,1920x0,auto,transform,0"];
    programs.zsh.shellAliases.vimhome = lib.mkForce "nvim ~/nixos/hosts/xtremecomputer1/home.nix";
    programs.zsh.shellAliases.vimconfig = lib.mkForce "nvim ~/nixos/hosts/xtremecomputer1/configuration.nix";
    programs.zsh.shellAliases.agenda = lib.mkForce "gcalcli agenda";

    home.sessionVariables = {
        EDITOR = "neovim";
        NIXHOST = "xtremecomputer1";
    };

# Let Home Manager install and manage itself.
    programs.home-manager.enable = true;
}
