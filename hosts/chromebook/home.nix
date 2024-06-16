{ config, pkgs, inputs, lib, ... }:

{
    imports = [
        ./../../modules/hyprland.nix
        ./../../modules/terminal.nix
        ./../../modules/music.nix
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

    nixpkgs.config = {
        allowUnfree = true;
        vivaldi = {
            enableWideVine = true;
            proprietaryCodecs = true;
        };
    };

    home.packages = with pkgs; [
        neovim

        (pkgs.writeShellScriptBin "screenshot" ''
         grim -g "$(slurp)" - | satty --filename - --output-filename ~/Pictures/Screenshots/satty-$(date '+%Y%m%d-%H:%M:%S').png
         ''
        )
    ];

# Home Manager is pretty good at managing dotfiles. The primary way to manage
# plain files is through 'home.file'.

    home.file = {
        ".config/nvim" = {
            recursive = true;
            source = config.dotfiles.directory+"/.config/nvim";
        };
        ".config/satty" = {
            recursive = true;
            source = config.dotfiles.directory+"/.config/satty";
        };
    };
# home manager can also manage your environment variables through
# 'home.sessionvariables'. if you don't want to manage your shell through home
# manager then you have to manually source 'hm-session-vars.sh' located at
# either
#
#  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
#
# or
#
#  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
#
# or
#
#  /etc/profiles/per-user/xtremejames1/etc/profile.d/hm-session-vars.sh
#
    home.sessionVariables = {
        editor = "neovim";
    };

   programs.git = {
       enable = true;
       userName  = "James Xiao";
       userEmail = "xtremejames1@gmail.com";
   };



# Let Home Manager install and manage itself.
    programs.home-manager.enable = true;
}
