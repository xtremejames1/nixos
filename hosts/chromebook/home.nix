{ config, pkgs, inputs, lib, ... }:

{
    imports = [
        ./../../modules/terminal.nix
        ./../../modules/git.nix
        ./../../modules/music.nix
        ./../../modules/browser.nix
        ./../../modules/nvim.nix
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
    home.stateVersion = "24.11"; # Please read the comment before changing.

    home.packages = with pkgs; [
        remmina
        waypipe
    ];

    home.sessionVariables = {
        editor = "neovim";
        NIXHOST = "chromebook";
    };

# CUSTOM MODULE OPTIONS
    programs.zsh.shellAliases.vimhome = lib.mkForce "nvim ~/nixos/hosts/chromebook/home.nix";
    programs.zsh.shellAliases.vimconfig = lib.mkForce "nvim ~/nixos/hosts/chromebook/configuration.nix";
    programs.zsh.shellAliases.agenda = lib.mkForce "gcalcli agenda";

# Let Home Manager install and manage itself.
    programs.home-manager.enable = true;
}
