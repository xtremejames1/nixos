{ inputs, pkgs, config, ...}:
{
    imports = [
        ./cliutils.nix
    ];
  home.packages = with pkgs; [
        wezterm
        kitty
        tmux
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
            du = "dust";
            df = "duf";
            fix_zsh_history = "~/fix_zsh_history.sh";
            vimhome = "vim ~/nixos/hosts/xtremecomputer1/home.nix";
            vimconfig = "vim ~/nixos/hosts/xtremecomputer1/configuration.nix";

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

 home.file = {
        ".p10k.zsh".source = config.dotfiles.directory+"/.p10k.zsh";
        ".wezterm.lua".source = config.dotfiles.directory+"/.wezterm.lua";
        ".tmux.conf".source = config.dotfiles.directory+"/.tmux.conf";
        ".tmux" = {
            recursive = true;
            source = config.dotfiles.directory+"/.tmux";
        };
 };
}
