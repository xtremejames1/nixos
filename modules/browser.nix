{ pkgs, inputs, ... }:
{
  imports = [
    inputs.zen-browser.homeModules.beta
  ];

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

  programs.zen-browser = {
    enable = true;
    policies = {
      DisableAppUpdate = true;
      DisableTelemetry = true;
      # find more options here: https://mozilla.github.io/policy-templates/
    };
  };
}
