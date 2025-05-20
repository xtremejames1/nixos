{ pkgs, lib, inputs, ... }:
{
    imports = [
        ./../../modules/nvim.nix
        ./../../modules/emacs.nix
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
    nixpkgs.config.allowUnfree = true;

    home.packages = with pkgs; [
        fastfetch
        libqalculate
        calcurse
        aichat
        feh
        gnupg
        wget
        clang
        python3Full
        direnv
        cmake
        gnumake
        pcl
        eigen
        boost.dev
        boost.out
        vtk
    ];

    # Add direnv hook to your shell
    programs.direnv = {
        enable = true;
        enableZshIntegration = true; # or zshIntegration = true;
        nix-direnv.enable = true;     # Improved direnv integration
    };

    # Make pythonify script executable and available in PATH 
    home.file.".config/nix/scripts/pythonify.sh" = {
        source = ../../dotfiles/scripts/pythonify.sh;  # Path from ~/nixos/hosts/xtremelaptop3/ to ~/nixos/dotfiles/scripts/
        executable = true;
    };

    home.shellAliases = {
        pythonify = "$HOME/.config/nix/scripts/pythonify.sh";
    };


# Home Manager is pretty good at managing dotfiles. The primary way to manage
# plain files is through 'home.file'.

    home.file = {
        ".config/vivaldi-stable.conf".text = "--password-store=gnome-libsecret";
    };

# CUSTOM MODULE OPTIONS
    programs.zsh.shellAliases.vimhome = lib.mkForce "nvim ~/nixos/hosts/xtremelaptop3/home.nix";
    programs.zsh.shellAliases.vimconfig = lib.mkForce "nvim ~/nixos/hosts/xtremelaptop3/configuration.nix";

    programs.git.userEmail = lib.mkForce "jx396@cornell.edu";
    programs.git.userName = lib.mkForce "James Xiao";

    home.sessionVariables = {
        NIXHOST = "xtremelaptop3";
    };

# Let Home Manager install and manage itself.
    programs.home-manager.enable = true;
}
