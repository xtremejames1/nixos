{ pkgs, config, ...}:
{
  home.packages = with pkgs; [
    tmux
  ];
  home.file = {
    ".tmux.conf".source = config.dotfiles.directory+"/.tmux.conf";
    # ".tmux" = {
    #   recursive = true;
    #   source = config.dotfiles.directory+"/.tmux";
    # };
  };
}
