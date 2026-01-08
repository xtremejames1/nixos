{ pkgs, config, ...}:
{
    imports = [
        ./zsh.nix
        ./tmux.nix
    ];
    home.packages = with pkgs; [
        wezterm
        kitty
    ];

    home.file = {
        ".wezterm.lua".source = config.dotfiles.directory+"/.wezterm.lua";
    };
    services.ssh-agent.enable = true;
}
