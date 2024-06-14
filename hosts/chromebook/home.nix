{ config, pkgs, inputs, lib, ... }:

let dotfileDirectory = ./../../dotfiles;
in
{
    imports = [
        ./../../modules/hyprland.nix
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
        tmux
            eza
            zoxide
            ripgrep
            atuin
            lazygit
            gh
            bat
            fzf
            fd
            broot
            tldr
            unzip
            delta
            cargo
            dust
            duf
            bottom
            gping
            neovim
            wezterm
            kitty

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
            rb = "~/nixos/rebuildChromebook.sh";
            du = "dust";
            df = "duf";
            vimhome = "nvim ~/nixos/hosts/chromebook/home.nix";
            vimconfig = "nvim ~/nixos/hosts/chromebook/configuration.nix";
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
        ".config/waybar/style.css".source = dotfileDirectory+"/.config/waybar/style.css";
        ".config/hypr/hyprlock.conf".source = dotfileDirectory+"/.config/hypr/hyprlock.conf";
        ".config/hypr/hypridle.conf".source = dotfileDirectory+"/.config/hypr/hypridle.conf";
        ".config/mako/config".source = dotfileDirectory+"/.config/mako/config";
        ".config/anyrun" = {
            recursive = true;
            source = dotfileDirectory+"/.config/anyrun";
        };
        ".config/yazi" = {
            recursive = true;
            source = dotfileDirectory+"/.config/yazi";
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

#    programs.git = {
#        enable = true;
#        userName  = "James Xiao";
#        userEmail = "xtremejames1@gmail.com";
#    };



# Let Home Manager install and manage itself.
    programs.home-manager.enable = true;
}
