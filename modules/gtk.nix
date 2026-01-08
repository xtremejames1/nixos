{pkgs, lib, config, ...}: {
  gtk = {
    enable = true;

    # The GTK Theme
    theme = {
      name = "Gruvbox-Dark";
      package = pkgs.gruvbox-gtk-theme;
    };

    # Matching Icon Theme
    iconTheme = {
      name = "Gruvbox-Plus-Dark";
      package = pkgs.gruvbox-plus-icons;
    };

    # Force dark mode settings for GTK4/Libadwaita apps
    gtk3.extraConfig.gtk-application-prefer-dark-theme = 1;
    gtk4.extraConfig.gtk-application-prefer-dark-theme = 1;
  };

  # Only configure dconf if dconf package is available in the system
  # This prevents errors when dconf service isn't running
  dconf = lib.mkIf (config.dconf.enable or false) {
    settings = {
      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
      };
    };
  };
}
