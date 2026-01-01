{
  pkgs,
  lib,
  inputs,
  ...
}: {
  imports = [
    ./../../modules/nvim.nix
    ./../../modules/git.nix
    ./../../modules/zsh.nix
    ./../../modules/tmux.nix
    ./../../modules/terminal.nix
    ./../../modules/browser.nix
    ./../../modules/glance.nix
    ./../../variables.nix
    inputs.nix-doom-emacs-unstraightened.hmModule
  ];

  home.username = "xtremejames1";
  home.homeDirectory = "/home/xtremejames1";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.

  nixpkgs.overlays = [inputs.nix-doom-emacs-unstraightened.overlays.default];

  home.packages = with pkgs; [
    fastfetch
    libqalculate
    calcurse
    aichat
    feh
    gnupg
    wget
    discord
    steam
    qbittorrent
    wayvnc
    SDL2
    sqlite
    waypipe
    sioyek
    zathura
    kdePackages.okular
    xournalpp
    typst
    octaveFull
    slack
    xorg.xhost
    inkscape
    orca-slicer
    usbutils
    udiskie
    udisks
    opam
    gnumake
    devpod
    # devpod-desktop
    vscode
    wireshark
    xfce.thunar
    zip
    gimp
    krita
    rquickshare
    imagemagick
    kdePackages.kdeconnect-kde
    ticktick
    deskreen
    remmina
    vlc
    mcap-cli
    chromium
    claude-code
    blender
    net-tools
    wine
    winetricks
    caligula
    gitkraken
    ruby
    SDL2
    libffi
    gitkraken
    obs-studio
    kdePackages.kdenlive
    arduino-ide
    unrar
    qmk
    qmk-udev-rules
    qmk_hid
    via
    vial
    putty
    opencode
    gemini-cli
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.

  home.file = {
  };

  # CUSTOM MODULE OPTIONS
  programs.zsh.shellAliases.vimhome = lib.mkForce "nvim ~/nixos/hosts/xtremelaptop3b/home.nix";
  programs.zsh.shellAliases.vimconfig = lib.mkForce "nvim ~/nixos/hosts/xtremelaptop3b/configuration.nix";
  programs.zsh.shellAliases.ad = lib.mkForce "~/nixos/dotfiles/scripts/wayvnc_setup.sh";

  home.sessionVariables = {
    NIXHOST = "xtremelaptop3b";
    NIXOS_OZONE_WL = "1";
  };

  xdg.mimeApps.defaultApplications = {
    "application/pdf" = "sioyek.desktop";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
