{ lib, ... }:
with lib;
{
  options.dotfiles = {
    directory = mkOption {
      type = types.path;
      default = ./dotfiles;
      description = "directory for dotfiles";
    };
  };
}
