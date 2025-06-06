{ pkgs, lib, config, ... }:
{
    imports = [
        ./cliutils.nix
    ];
    home.file = {
        ".p10k.zsh".source = config.dotfiles.directory+"/.p10k.zsh";
    };
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    sessionVariables = {
      RUST_BACKTRACE=1;
    };
    shellAliases = {
      ls = "eza";
      vim = "nvim";
      grep = "rg";
      cat = "bat";
      rb = "~/nixos/rebuild.sh";
      du = "dust";
      df = "duf";
      fix_zsh_history = "~/fix_zsh_history.sh";
      vimhome = "vim ~/nixos/hosts/xtremecomputer1/home.nix";
      vimconfig = "vim ~/nixos/hosts/xtremecomputer1/configuration.nix";

    };
    initContent = ''
      path+=('/home/xtremejames1/.local/bin')
      export PAT

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
          "last-working-dir"
          "history"
          "gh"
          "fzf"
          "fasd"
      ];
    };
  };

  programs.oh-my-posh = {
    enable = true;
    settings = builtins.fromJSON (builtins.readFile "/home/xtremejames1/nixos/dotfiles/.config/oh-my-posh/xtr3m.omp.json");
  };
}
