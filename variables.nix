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
  options.host = {
    name = mkOption {
      type = types.str;
      default = "xtremecomputer1";
      description = "hostname";
    };
  };
}
