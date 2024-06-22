{ config, pkgs, inputs, lib, ... }:

{
    imports = [
        ./../../modules/hyprland.nix
        ./../../modules/terminal.nix
        ./../../modules/git.nix
        ./../../modules/music.nix
        ./../../modules/browser.nix
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

    ];

# Home Manager is pretty good at managing dotfiles. The primary way to manage
# plain files is through 'home.file'.

    home.file = {
        ".config/nvim" = {
            recursive = true;
            source = config.dotfiles.directory+"/.config/nvim";
        };
    };

# Custom Module Options
    wayland.windowManager.hyprland.settings.monitor = lib.mkForce ["eDP-1,preferred,auto,auto,transform,0"];

    home.sessionVariables = {
        editor = "neovim";
        NIXHOST = "chromebook";
    };


# Let Home Manager install and manage itself.
    programs.home-manager.enable = true;
}
