{ config, pkgs, inputs, lib, ... }:

let dotfileDirectory = ./../../dotfiles;
in
{
    imports = [
        ./../../packages/orcaslicer-appimage.nix
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
    home.packages = [
    pkgs.tmux
    pkgs.eza
    pkgs.zoxide
    pkgs.ripgrep
    pkgs.atuin
    pkgs.git
    pkgs.lazygit
    pkgs.gh
    pkgs.bat
    pkgs.fzf
    pkgs.fd
    pkgs.broot
    pkgs.tldr
    pkgs.unzip
    pkgs.delta
            pkgs.vivaldi
            pkgs.vivaldi-ffmpeg-codecs
            pkgs.widevine-cdm
            pkgs.chromium
            pkgs.neovim
            pkgs.discord
            pkgs.obsidian
            pkgs.gcc
            pkgs.xcape
            pkgs.interception-tools
            pkgs.nodejs_21
            pkgs.sqlite
            pkgs.obs-studio
            pkgs.rustc
            inputs.nixpkgs-unstable.legacyPackages."${pkgs.system}".kicad
            pkgs.cmake
            pkgs.lollypop
            pkgs.vlc
            pkgs.subversion
            pkgs.python3
            pkgs.gdown
            pkgs.rustup
            pkgs.steam
            pkgs.lutris
            pkgs.bottles
            pkgs.git-interactive-rebase-tool
            pkgs.lua-language-server
            pkgs.wineWowPackages.stable
            pkgs.syncthing

            (pkgs.nerdfonts.override { fonts = [ "IosevkaTerm" ]; })

# # You can also create simple shell scripts directly inside your
# # configuration. For example, this adds a command 'my-hello' to your
# # environment:
# (pkgs.writeShellScriptBin "my-hello" ''
#   echo "Hello, ${config.home.username}!"
# '')
            ];
            
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    shellAliases = {
      ls = "eza";
      vim = "nvim";
      grep = "rg";
      cat = "bat";
      rb = "~/nixos/rebuild.sh";
    };
    initExtra = ''
      source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
      source ~/.p10k.zsh
      if [[ -n $SSH_CONNECTION ]]; then
        export EDITOR='vim'
      else
        export EDITOR='nvim'
          fi

          eval "$(zoxide init --cmd cd zsh)"
          eval "$(atuin init zsh)"

          bindkey -v

          MODE_CURSOR_VIINS="#dce0b1 blinking bar"
          MODE_CURSOR_REPLACE="blinking underline #8a3129"
          MODE_CURSOR_VICMD="#5c7a38 blinking block"
          MODE_CURSOR_SEARCH="#ff00ff steady underline"
          MODE_CURSOR_VISUAL="$MODE_CURSOR_VICMD steady bar"
          MODE_CURSOR_VLINE="$MODE_CURSOR_VISUAL #00ffff"
          '';

    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
          "history"
          "tmux"
          "vi-mode"
          "web-search"
          "ripgrep"
          "last-working-dir"
          "history"
          "gh"
          "fzf"
          "fd"
          "fasd"
      ];
    };
  };

# Home Manager is pretty good at managing dotfiles. The primary way to manage
# plain files is through 'home.file'.

    home.file = {
        ".p10k.zsh".source = dotfileDirectory+"/.p10k.zsh";
        ".wezterm.lua".source = dotfileDirectory+"/.wezterm.lua";
        ".config/nvim" = {
            recursive = true;
            source = dotfileDirectory+"/.config/nvim";
        };
        ".tmux.conf".source = dotfileDirectory+"/.tmux.conf";
        ".tmux" = {
            recursive = true;
            source = dotfileDirectory+"/.tmux";
        };
    };

# Home Manager can also manage your environment variables through
# 'home.sessionVariables'. If you don't want to manage your shell through Home
# Manager then you have to manually source 'hm-session-vars.sh' located at
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
        EDITOR = "neovim";
    };

    programs.git = {
        enable = true;
        userName  = "James Xiao";
        userEmail = "xtremejames1@gmail.com";
    };



# Let Home Manager install and manage itself.
    programs.home-manager.enable = true;
}
