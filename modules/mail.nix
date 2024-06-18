{ inputs, pkgs, config, ... }:
{
  programs.neomutt = {
    enable = true;
    vimKeys = true;
  };
  # accounts.email = {
  #   accounts.xtremejames1 = {
  #     address = "xtremejames1@gmail.com";
  #     
  #   };
  # };

  home.file = {
    ".config/mutt" = {
      recursive = true;
      source = config.dotfiles.directory+"/.config/mutt";
    };
  };
}
