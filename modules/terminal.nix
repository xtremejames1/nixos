{ inputs, pkgs, config, ...}:
{
    imports = [
        ./zsh.nix
    ];
  home.packages = with pkgs; [
        wezterm
        kitty
        tmux
  ];

 home.file = {
        ".wezterm.lua".source = config.dotfiles.directory+"/.wezterm.lua";
        ".tmux.conf".source = config.dotfiles.directory+"/.tmux.conf";
        ".tmux" = {
            recursive = true;
            source = config.dotfiles.directory+"/.tmux";
        };
 };
}
