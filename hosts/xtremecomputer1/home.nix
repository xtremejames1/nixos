{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
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
    };
};
  home.packages = [
    pkgs.tmux
    pkgs.eza
    pkgs.zoxide
    pkgs.ripgrep
    pkgs.atuin
    pkgs.git
    pkgs.gh
    pkgs.bat
    pkgs.fzf
    pkgs.fd
    pkgs.broot
    pkgs.vivaldi
    pkgs.widevine-cdm
    pkgs.neovim
    pkgs.discord
    pkgs.obsidian
    pkgs.gcc
    pkgs.xcape
    pkgs.interception-tools

    
    (pkgs.nerdfonts.override { fonts = [ "IosevkaTerm" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # ".zshrc".source = config.lib.file.mkOutOfStoreSymlink "/home/xtremejames1/nixos/dotfiles/.zshrc";
    # ".zshrc".source = ~/nixos/dotfiles/.zshrc;
    ".p10k.zsh".source = /home/xtremejames1/nixos/dotfiles/.p10k.zsh;
    ".wezterm.lua".source = /home/xtremejames1/nixos/dotfiles/.wezterm.lua;
    ".config/nvim" = {
      recursive = true;
      source = /home/xtremejames1/nixos/dotfiles/.config/nvim;
    };

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
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

  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    shellAliases = {
      ls = "eza";
      vim = "nvim";
      grep = "rg";
      cat = "bat";
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

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
