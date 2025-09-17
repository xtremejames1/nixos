{ pkgs, config, lib, ... }:
{
  home.packages = with pkgs; [
    # screenshot
    satty
    grim
    slurp

    (pkgs.writeShellScriptBin "screenshot" ''
         grim -g "$(slurp -c '#ff0000ff')" - | satty --filename - --fullscreen --output-filename ~/Pictures/Screenshots/satty-$(date '+%Y%m%d-%H:%M:%S').png
         ''
    )
  ];

  home.file = {
    ".config/satty" = {
      recursive = true;
      source = config.dotfiles.directory+"/.config/satty";
    };
  };
}
