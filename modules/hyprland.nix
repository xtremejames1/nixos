{ inputs, pkgs, config, ...}:
{
  home.packages = with pkgs; [
    hyprpaper
      libnotify
      mako
      hyprlock
      bemenu
      pavucontrol
      pamixer
      xdg-desktop-portal-hyprland
      brightnessctl
      hypridle
      pcmanfm
      yazi
      anyrun
      swayosd
      satty
      ianny
      anyrun
      satty
      ianny
      swaynotificationcenter
  ];

  home.file = {
        ".config/waybar/style.css".source = config.dotfiles.directory+"/.config/waybar/style.css";
        ".config/hypr/hyprlock.conf".source = config.dotfiles.directory+"/.config/hypr/hyprlock.conf";
        ".config/hypr/hypridle.conf".source = config.dotfiles.directory+"/.config/hypr/hypridle.conf";
        ".config/mako/config".source = config.dotfiles.directory+"/.config/mako/config";
        ".config/anyrun" = {
            recursive = true;
            source = config.dotfiles.directory+"/.config/anyrun";
        };
        ".config/yazi" = {
            recursive = true;
            source = config.dotfiles.directory+"/.config/yazi";
        };
  };

  services.swayosd.enable = true;

  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 24;
        modules-left = ["hyprland/workspaces"];
        modules-center = ["hyprland/window"];
        modules-right = ["pulseaudio" "network" "cpu" "memory" "power-profiles-daemon" "battery" "tray" "clock"];
        "hyprland/workspaces" = {
          format = "<sup>{icon}</sup> {windows}";
          format-window-separator = "  ";
          window-rewrite-default = "";
          window-rewrite = {
            "title<.*YouTube.*>" = "";
            "title<.*GitHub.*>" = "";
            "title<.*Vivaldi" = "";
            "title<.*vim.*>" = "";
            "wezterm" = "";
          };
        };
        tray = {
          icon-size = 21;
          spacing = 10;
        };
        clock = {
          format-alt = "{:%Y-%m-%d}";
        };
        cpu = {
          format = "{usage}% ";
        };
        memory = {
          format = "{}% ";
        };
        power-profiles-daemon = {
          format = "{icon}";
          tooltip-format = "Power profile: {profile}\nDriver: {driver}";
          tooltip = true;
          format-icons = {
            default = "";
            performance = "";
            balanced = "";
            power-saver = "";
          };
        };
        battery = {
          bat = "BAT0";
          states = {
            full = 100;
            good = 90;
            warning = 35;
            critical = 15;
          };
          format = "{capacity}% {icon}";
# // "format-good": ""; // An empty format will hide the module
# // "format-full": "";
          format-icons = ["" "" "" "" ""];
        };
        network = {
# interface = "wlp2s0";
          format-wifi = "{essid} ({signalStrength}%) ";
          format-ethernet = "{ifname}: {ipaddr}/{cidr} ";
          format-disconnected = "Disconnected ⚠";
        };
        pulseaudio = {
          format = "{volume}% {icon}";
          format-bluetooth = "{volume}% {icon}";
          format-muted = "";
          format-icons = {
            headphones = "";
            handsfree = "";
            headset = "";
            phone = "";
            portable = "";
            car = "";
            default = ["" ""];
          };
          on-click = "pamixer -t";
          on-click-right = "pavucontrol";
        };
      };

    };
  };
  wayland.windowManager.hyprland = {
    enable = true;
    plugins = [
    ];
    settings = {
      monitor = "eDP-1,preferred,auto,auto,transform,0";

# launch apps on startup
      exec-once = "waybar & hyprpaper & mako & hypridle & iio-hyprland eDP-1";

# default apps
      "$terminal" = "wezterm";
      "$fileManager" = "wezterm start -- yazi";
      "$menu" = "bemenu-run --binding vim";
      "$browser" = "vivaldi";

      env = [
        "XCURSOR_SIZE,24"
          "QT_QPA_PLATFORMTHEME,qt5ct"
      ];

      input = {
        kb_layout = "us";
        follow_mouse = "1";
        accel_profile = "flat";
        touchpad = {
          natural_scroll = "yes";
          scroll_factor = "0.1";
          clickfinger_behavior = "true";
        };

        sensitivity = "0.2";
      };

      general = {
        gaps_in = "2";
        gaps_out = "6";
        border_size = "1";
        "col.active_border" = "rgba(7a6a33ee) rgba(faffa3ee) 45deg";
        "col.inactive_border" = "rgba(595959aa)";

        layout = "dwindle";

        allow_tearing = "false";
      };

      decoration = {
        rounding = "5";
        inactive_opacity = "0.8";

        blur = {
          enabled = "true";
          size = "3";
          passes = "1";
        };

        drop_shadow = "yes";
        shadow_range = "4";
        shadow_render_power = "3";
        "col.shadow" = "rgba(1a1a1aee)";
      };

      animations = {
        enabled = "yes";
        bezier = [
          "myBezier, 0.05, 0.9, 0.1, 1.05"
            "expOut, .16, 1, 0.3, 1"
            "easeOutBack, 0.34, 1.56, 0.69, 0.97"
        ];

        animation = [
          "windows, 1, 3, myBezier"
            "windowsOut, 1, 4, default, popin 80%"
            "border, 1, 3, easeOutBack"
            "borderangle, 1, 4, default"
            "fade, 1, 4, default"
            "workspaces, 1, 4, expOut"
        ];
      };
      dwindle = {
# See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
        pseudotile = "yes";
        preserve_split = "yes";
      };
      master = {
        new_is_master = "true";
      };
      gestures = {
        workspace_swipe = "on";
      };
      misc = {
        force_default_wallpaper = "0";
        disable_hyprland_logo = "true";
      };

# BINDS

      "$mainMod" = "SUPER";
      bind = [
        "$mainMod, Q, exec, $terminal"
          "$mainMod, C, killactive,"
          "$mainMod, M, exit,"
          "$mainMod, E, exec, $fileManager"
          "$mainMod, V, togglefloating, "
          "$mainMod, R, exec, $menu"
          "$mainMod, B, exec, $browser"
          "$mainMod SHIFT, L, exec, hyprlock"
          "ALT, Space, exec, anyrun"
#dwindle
          "$mainMod, P, pseudo,"
          "$mainMod, space, togglesplit,"
# Move focus with mainMod + arrow keys
          "$mainMod, H, movefocus, l"
          "$mainMod, L, movefocus, r"
          "$mainMod, K, movefocus, u"
          "$mainMod, J, movefocus, d"
# Switch workspaces with mainMod + [0-9]
          "$mainMod, 1, workspace, 1"
          "$mainMod, 2, workspace, 2"
          "$mainMod, 3, workspace, 3"
          "$mainMod, 4, workspace, 4"
          "$mainMod, 5, workspace, 5"
          "$mainMod, 6, workspace, 6"
          "$mainMod, 7, workspace, 7"
          "$mainMod, 8, workspace, 8"
          "$mainMod, 9, workspace, 9"
          "$mainMod, 0, workspace, 10"
# Move active window to a workspace with mainMod + SHIFT + [0-9]
          "$mainMod SHIFT, 1, movetoworkspace, 1"
          "$mainMod SHIFT, 2, movetoworkspace, 2"
          "$mainMod SHIFT, 3, movetoworkspace, 3"
          "$mainMod SHIFT, 4, movetoworkspace, 4"
          "$mainMod SHIFT, 5, movetoworkspace, 5"
          "$mainMod SHIFT, 6, movetoworkspace, 6"
          "$mainMod SHIFT, 7, movetoworkspace, 7"
          "$mainMod SHIFT, 8, movetoworkspace, 8"
          "$mainMod SHIFT, 9, movetoworkspace, 9"
          "$mainMod SHIFT, 0, movetoworkspace, 10"
# Example special workspace (scratchpad)
          "$mainMod, S, togglespecialworkspace, magic"
          "$mainMod SHIFT, S, movetoworkspace, special:magic"
# Scroll through existing workspaces with mainMod + scroll
          "$mainMod, mouse_down, workspace, e+1"
          "$mainMod, mouse_up, workspace, e-1"
          ];
      bindle = [
# Volume up/down
        ", XF86AudioRaiseVolume, exec, pamixer -i 5"
          ", XF86AudioLowerVolume, exec, pamixer -d 5"
          ", XF86MonBrightnessUp, exec, brightnessctl set +5%"
          ", XF86MonBrightnessDown, exec, brightnessctl set 5%-"
      ];
      bindl = [
# Volume mute
        ", XF86AudioMute, exec, pamixer -t"
# Tablet mode switch
          ", switch:on:[Tablet Mode Switch], exec, notify-send bruh"
          ", switch:off:[Tablet Mode Switch], exec, notify-send bruh"
      ];
      bindm = [
# Move/resize windows with mainMod + LMB/RMB and dragging
        "$mainMod, mouse:272, movewindow"
          "$mainMod, mouse:273, resizewindow"
      ];

    };
    extraConfig = ''

# Example windowrule v1
# windowrule = float, ^(kitty)$
# Example windowrule v2
# windowrulev2 = float,class:^(kitty)$,title:^(kitty)$
# See https://wiki.hyprland.org/Configuring/Window-Rules/ for more
      windowrulev2 = suppressevent maximize, class:.* # You'll probably like this.
                                                        '';
  };
}
