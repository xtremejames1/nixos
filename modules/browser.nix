{ pkgs, ... }:
{
  home.packages = with pkgs; [
    vivaldi
    vivaldi-ffmpeg-codecs
    widevine-cdm
  ];

  nixpkgs.config = {
    allowUnfree = true;
    vivaldi = {
      enableWideVine = true;
      proprietaryCodecs = true;
    };
  };

}
