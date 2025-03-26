# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

# NixOS-WSL specific options are documented on the NixOS-WSL repository:
# https://github.com/nix-community/NixOS-WSL

{ pkgs, inputs, lib, ... }:

{
  imports = [
    # include NixOS-WSL modules
    # <nixos-wsl/modules>
    ./hardware-configuration.nix
    ./../../variables.nix
    inputs.home-manager.nixosModules.default
  ];

  nix.settings.experimental-features = "nix-command flakes";

  # wsl.enable = true;
  # wsl.defaultUser = "xtremejames1";
  # wsl.wslConf.network.hostname = "xtremelaptop3";

  programs.zsh.enable = true;

  fonts.packages = with pkgs; [
    nerd-fonts.iosevka-term
    overpass
  ];

  home-manager = {
    extraSpecialArgs = {
      inherit inputs;
     };
    users = {
      "xtremejames1" = import ./home.nix;
    };
  };

  time.timeZone = lib.mkDefault "America/New_York";

  systemd.timers."ics2org" = {
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnBootSec = "15m";
      OnUnitActiveSec = "15m";
      Unit = "ics2org.service";
    };
  };

  systemd.services."ics2org" = {
    path = [ pkgs.bash pkgs.wget pkgs.gawk ];
    serviceConfig = {
      ExecStart = "/home/xtremejames1/nixos/dotfiles/scripts/ics2org.sh";
    };
  };

  services.syncthing = {
    dataDir = "/home/xtremejames1/";
    user = "xtremejames1";
    enable = true;
    openDefaultPorts = true;
    settings = {
      devices = {
        "pixel" = { id = "2J6HT27-HTLX6OI-3SRU25T-G3I3MY4-Q5F7TZJ-6ZQ7ZBY-3BRGBX2-HRNWXA6"; };
      };
      folders = {
        "org" = {
          path = "/home/xtremejames1/org";
          devices = [ "pixel" ];
        };
      };
    };
  };

  services.pcscd.enable = true;
  programs.gnupg.agent = {
    enable = true;
    pinentryPackage = pkgs.pinentry-curses;
    enableSSHSupport = true;
  };

  # environment.systemPackages = with pkgs; [
  # ];

  environment.variables = {
    EDITOR = "neovim";
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
}
