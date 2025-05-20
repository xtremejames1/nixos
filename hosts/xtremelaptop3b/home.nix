{ pkgs, lib, inputs, ... }:
{
    imports = [
        ./../../modules/nvim.nix
        ./../../modules/git.nix
        ./../../modules/zsh.nix
        ./../../modules/tmux.nix
        ./../../variables.nix
        inputs.nix-doom-emacs-unstraightened.hmModule
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

    nixpkgs.overlays = [ inputs.nix-doom-emacs-unstraightened.overlays.default ];

    home.packages = with pkgs; [
        fastfetch
        libqalculate
        calcurse
        aichat
        feh
        gnupg
        wget
    ];

# Home Manager is pretty good at managing dotfiles. The primary way to manage
# plain files is through 'home.file'.

    home.file = {
    };

# CUSTOM MODULE OPTIONS
    programs.zsh.shellAliases.vimhome = lib.mkForce "nvim ~/nixos/hosts/xtremelaptop3b/home.nix";
    programs.zsh.shellAliases.vimconfig = lib.mkForce "nvim ~/nixos/hosts/xtremelaptop3b/configuration.nix";

    home.sessionVariables = {
        NIXHOST = "xtremelaptop3b";
    };

# Let Home Manager install and manage itself.
    programs.home-manager.enable = true;
}
