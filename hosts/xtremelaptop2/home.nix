{ config, pkgs, inputs, lib, ... }:
{
    imports = [
        ./../../modules/tmux.nix
        ./../../modules/zsh.nix
        ./../../modules/git.nix
        ./../../modules/calendar.nix
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
        volta
        nodejs_20
        yarn
        foliate
        tcpdump
        azure-cli
        azure-cli-extensions.image-copy-extension
    ];

# Home Manager is pretty good at managing dotfiles. The primary way to manage
# plain files is through 'home.file'.

    home.file = {
        ".config/nvim" = {
            recursive = true;
            source = config.dotfiles.directory+"/.config/nvim";
        };
        ".config/nvim/lua/custom/config/init.lua".text = ''
        require('wsl.lua');
        '';
        ".config/nvim/lua/custom/config/wsl.lua".text = ''
            vim.g.clipboard = {
                name = 'WslClipboard',
                copy = {
                    ['+'] = { 'clip.exe' },
                    ['*'] = { 'clip.exe' },
                },
                paste = {
                    ['+'] = { 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))' },
                    ['*'] = { 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))' },
                },
                cache_enabled = 0,
            }
        '';
        ".wezterm.lua".source = config.dotfiles.directory+"/.wezterm.lua";
    };

# CUSTOM MODULE OPTIONS
    programs.zsh.shellAliases.vimhome = lib.mkForce "nvim ~/nixos/hosts/xtremelaptop2/home.nix";
    programs.zsh.shellAliases.rb = lib.mkForce "~/nixos/homeRebuild.sh";
    

    home.sessionVariables = {
        EDITOR = "neovim";
        NIXHOST = "xtremelaptop2";
    };

    home.sessionPath = [
        "$HOME/.local/bin"
    ];

# Let Home Manager install and manage itself.
    programs.home-manager.enable = true;
}
