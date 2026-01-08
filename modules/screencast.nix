{pkgs, ... }:
{
  xdg.portal = {

    enable = true;
    wlr.enable = true;
    xdgOpenUsePortal = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-gnome
      pkgs.xdg-desktop-portal-wlr
    ];
    config = {
      common = {
        default = "wlr";
        "org.freedesktop.impl.portal.ScreenCast" = "wlr";
        "org.freedesktop.impl.portal.Screenshot" = "wlr";
      };
    };
  };

  services.dbus.enable = true;

  networking.firewall.trustedInterfaces = [ "p2p-wl+" ];
  # Overlay to patch gnome-network-displays
  nixpkgs.overlays = [
    (final: prev: {
      gnome-network-displays = prev.gnome-network-displays.overrideAttrs (oldAttrs: {
        postPatch = (oldAttrs.postPatch or "") + ''
          # Find the nd-stream.c file and patch it
          echo "Looking for nd-stream.c file..."
          find . -name "nd-stream.c" -type f | while read -r file; do
            echo "Found file at: $file"
            substituteInPlace "$file" \
              --replace "XDP_OUTPUT_MONITOR | XDP_OUTPUT_WINDOW | XDP_OUTPUT_VIRTUAL" \
                        "XDP_OUTPUT_MONITOR"
          done
        '';
      });
    })
  ];

  environment.systemPackages = with pkgs; [
    glib
    gnome-network-displays
  ];

  networking.firewall.allowedTCPPorts = [ 7236 7250];
  networking.firewall.allowedUDPPorts = [ 7236 5353];
}
