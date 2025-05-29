{ pkgs, lib, config, ... }:
{
  imports = [
    ./screenshot.nix
  ];

  wayland.windowManager.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    config = rec {
      modifier = "Mod1";
      terminal = "wezterm";
      menu = "rofi -show run";
      keybindings = let
        modifier = config.wayland.windowManager.sway.config.modifier;
        menu = config.wayland.windowManager.sway.config.menu;
        browser = "zen";
        explorer = "wezterm start -- yazi";
      in lib.mkOptionDefault {
          "Mod4+B" = "exec ${browser}";
          "Mod4+E" = "exec ${explorer}";
          "Mod4+R" = "exec ${menu}";
          "Mod4+L" = "exec hyprlock";
          "Mod4+Shift+S" = "exec screenshot";
          "XF86AudioMute" = "exec pamixer -t";
          "XF86AudioRaiseVolume" = "exec pamixer -i 5";
          "XF86AudioLowerVolume" = "exec pamixer -d 5";
          "XF86MonBrightnessUp" = "exec brightnessctl set +5%";
          "XF86MonBrightnessDown" = "exec brightnessctl set 5%-";
        };
      startup = [
        { command = "wezterm"; }
        { command = "waybar & swaync & ianny"; }
      ];
      input = {
        "*" = {
          repeat_delay = "250";
          repeat_rate = "20";
        };
        "type:touchpad" = {
          natural_scroll = "enabled";
          tap = "enabled";         # enables click-on-tap
          tap_button_map = "lrm";  # tap with 1 finger = left click, 2 fingers = right click, 3 fingers = middle click
          dwt = "enabled";         # disable (touchpad) while typing
          dwtp = "enabled";        # disable (touchpad) while track pointing
          accel_profile = "flat";  # disable mouse acceleration (enabled by default; to set it manually, use "adaptive" instead of "flat")
          pointer_accel = "0.8";   # set mouse sensitivity (between -1 and 1)
          scroll_factor = "0.2";    # set scroll speed (between 0.0 and 1.0)
        };
        "type:mouse" = {
          accel_profile = "flat";  # disable mouse acceleration (enabled by default; to set it manually, use "adaptive" instead of "flat")
          pointer_accel = "0.8";   # set mouse sensitivity (between -1 and 1)
        };
        "2:10:TPPS/2_IBM_TrackPoint" = {
          dwt = "enabled";         # disable (touchpad) while typing
          accel_profile = "flat";  # disable mouse acceleration (enabled by default; to set it manually, use "adaptive" instead of "flat")
          pointer_accel = "0.2";   # set mouse sensitivity (between -1 and 1)
        };
      };
    };
    extraConfig = ''
      for_window [class=".*"] inhibit_idle fullscreen
      for_window [app_id=".*"] inhibit_idle fullscreen
      '';
  };

  # Enable a secret service provider
  services.gnome-keyring.enable = true;

  home.packages = with pkgs; [
    libnotify
    rofi-wayland

    pavucontrol
    pamixer

    wl-clipboard
    brightnessctl
    yazi
    anyrun
    ianny
  ];

  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        disable_loading_bar = true;
        grace = 5;
        hide_cursor = false;
        no_fade_in = false;
      };

      input-field = [
        {
          size = "200, 50";
          position = "0, -80";
          monitor = "";
          dots_center = true;
          fade_on_empty = false;
          font_color = "rgb(202, 211, 245)";
          inner_color = "rgb(91, 96, 120)";
          outer_color = "rgb(24, 25, 38)";
          outline_thickness = 5;
          placeholder_text = "Password...";
          shadow_passes = 2;
        }
      ];
    };
  };

  services.swayidle = {
    enable = true;
    events = [
        { event = "lock"; command = "${pkgs.hyprlock}/bin/hyprlock"; }
        { event = "before-sleep"; command = "${pkgs.hyprlock}/bin/hyprlock";
        }
    ];
    timeouts = [
        { timeout = 180; command = "${pkgs.hyprlock}/bin/hyprlock"; }
    ];
  };

  # Cursors
  # https://nixos.wiki/wiki/Cursor_Themes

  # home.file.".icons/default".source = "${pkgs.posy-cursors}/share/icons/Posy_Cursor";
  home.file.".icons/default".source = "${pkgs.apple-cursor}/share/icons/macOS";

  home.file = {
    ".config/waybar/style.css".source = config.dotfiles.directory+"/.config/waybar/style.css";
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

  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 24;
        modules-left = ["sway/workspaces"];
        modules-center = ["sway/window"];
        modules-right = ["pulseaudio" "network" "cpu" "memory" "power-profiles-daemon" "battery" "tray" "clock" "custom/notifications"];
        "sway/workspaces" = {
          format = "<sup>{icon}</sup> {windows}";
          format-window-separator = "  ";
          window-rewrite-default = "";
          window-rewrite = {
            "title<.*YouTube.*>" = "";
            "title<.*GitHub.*>" = "";
            "title<.*Zen" = "";
            "title<.*vim.*>" = "";
            "wezterm" = "";
            "obsidian" = "󰠮";
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
          on-click-right = "wezterm start -- nmtui";
        };
        pulseaudio = {
          format = "{volume}% {icon}";
          format-bluetooth = "{volume}% {icon}";
          format-muted = "";
          format-icons = {
            headphones = "";
            handsfree = "󰋎";
            headset = "󰋎";
            phone = "";
            portable = "";
            car = "";
            default = ["" ""];
          };
          on-click = "pamixer -t";
          on-click-right = "pavucontrol";
        };
      };
      "custom/notification" = {
        "tooltip" = false;
        format = "{icon}";
        format-icons = {
          notification = "<span foreground='red'><sup></sup></span>";
          none = "";
          dnd-notification = "<span foreground='red'><sup></sup></span>";
          dnd-none = "";
          inhibited-notification = "<span foreground='red'><sup></sup></span>";
          inhibited-none = "";
          dnd-inhibited-notification = "<span foreground='red'><sup></sup></span>";
          dnd-inhibited-none = "";
        };
        return-type = "json";
        exec-if = "which swaync-client";
        exec = "swaync-client -swb";
        on-click = "swaync-client -t -sw";
        on-click-right = "swaync-client -d -sw";
        escape = true;
      };
    };
  };

  #SWAY NOTIFICTAION CENTER
  services.swaync = {
    enable = true;
    settings = {
      notification-icon-size = 32;
      notification-body-image-height = 100;
      notification-body-image-width = 200;
      notification-window-width = 380;
    };
    style = ''
        * {
all: unset;
     font-size: 14px;
     font-family: "Ubuntu Nerd Font";
transition: 200ms;
        }

      trough highlight {
background: #cdd6f4;
      }

      scale trough {
margin: 0rem 1rem;
        background-color: #313244;
        min-height: 8px;
        min-width: 70px;
      }

      slider {
        background-color: #89b4fa;
      }

      .floating-notifications.background .notification-row .notification-background {
        box-shadow: 0 0 8px 0 rgba(0, 0, 0, 0.8), inset 0 0 0 1px #313244;
        border-radius: 12.6px;
margin: 18px;
        background-color: #1e1e2e;
color: #cdd6f4;
padding: 0;
      }

      .floating-notifications.background .notification-row .notification-background .notification {
padding: 7px;
         border-radius: 12.6px;
      }

      .floating-notifications.background .notification-row .notification-background .notification.critical {
        box-shadow: inset 0 0 7px 0 #f38ba8;
      }

      .floating-notifications.background .notification-row .notification-background .notification .notification-content {
margin: 7px;
      }

      .floating-notifications.background .notification-row .notification-background .notification .notification-content .summary {
color: #cdd6f4;
      }

      .floating-notifications.background .notification-row .notification-background .notification .notification-content .time {
color: #a6adc8;
      }

      .floating-notifications.background .notification-row .notification-background .notification .notification-content .body {
color: #cdd6f4;
      }

      .floating-notifications.background .notification-row .notification-background .notification > *:last-child > * {
        min-height: 3.4em;
      }

      .floating-notifications.background .notification-row .notification-background .notification > *:last-child > * .notification-action {
        border-radius: 7px;
color: #cdd6f4;
       background-color: #313244;
       box-shadow: inset 0 0 0 1px #45475a;
margin: 7px;
      }

      .floating-notifications.background .notification-row .notification-background .notification > *:last-child > * .notification-action:hover {
        box-shadow: inset 0 0 0 1px #45475a;
        background-color: #313244;
color: #cdd6f4;
      }

      .floating-notifications.background .notification-row .notification-background .notification > *:last-child > * .notification-action:active {
        box-shadow: inset 0 0 0 1px #45475a;
        background-color: #74c7ec;
color: #cdd6f4;
      }

      .floating-notifications.background .notification-row .notification-background .close-button {
margin: 7px;
padding: 2px;
         border-radius: 6.3px;
color: #1e1e2e;
       background-color: #f38ba8;
      }

      .floating-notifications.background .notification-row .notification-background .close-button:hover {
        background-color: #eba0ac;
color: #1e1e2e;
      }

      .floating-notifications.background .notification-row .notification-background .close-button:active {
        background-color: #f38ba8;
color: #1e1e2e;
      }

      .control-center {
        box-shadow: 0 0 8px 0 rgba(0, 0, 0, 0.8), inset 0 0 0 1px #313244;
        border-radius: 12.6px;
margin: 18px;
        background-color: #1e1e2e;
color: #cdd6f4;
padding: 14px;
      }

      .control-center .widget-title > label {
color: #cdd6f4;
       font-size: 1.3em;
      }

      .control-center .widget-title button {
        border-radius: 7px;
color: #cdd6f4;
       background-color: #313244;
       box-shadow: inset 0 0 0 1px #45475a;
padding: 8px;
      }

      .control-center .widget-title button:hover {
        box-shadow: inset 0 0 0 1px #45475a;
        background-color: #585b70;
color: #cdd6f4;
      }

      .control-center .widget-title button:active {
        box-shadow: inset 0 0 0 1px #45475a;
        background-color: #74c7ec;
color: #1e1e2e;
      }

      .control-center .notification-row .notification-background {
        border-radius: 7px;
color: #cdd6f4;
       background-color: #313244;
       box-shadow: inset 0 0 0 1px #45475a;
       margin-top: 14px;
      }

      .control-center .notification-row .notification-background .notification {
padding: 7px;
         border-radius: 7px;
      }

      .control-center .notification-row .notification-background .notification.critical {
        box-shadow: inset 0 0 7px 0 #f38ba8;
      }

      .control-center .notification-row .notification-background .notification .notification-content {
margin: 7px;
      }

      .control-center .notification-row .notification-background .notification .notification-content .summary {
color: #cdd6f4;
      }

      .control-center .notification-row .notification-background .notification .notification-content .time {
color: #a6adc8;
      }

      .control-center .notification-row .notification-background .notification .notification-content .body {
color: #cdd6f4;
      }

      .control-center .notification-row .notification-background .notification > *:last-child > * {
        min-height: 3.4em;
      }

      .control-center .notification-row .notification-background .notification > *:last-child > * .notification-action {
        border-radius: 7px;
color: #cdd6f4;
       background-color: #11111b;
       box-shadow: inset 0 0 0 1px #45475a;
margin: 7px;
      }

      .control-center .notification-row .notification-background .notification > *:last-child > * .notification-action:hover {
        box-shadow: inset 0 0 0 1px #45475a;
        background-color: #313244;
color: #cdd6f4;
      }

      .control-center .notification-row .notification-background .notification > *:last-child > * .notification-action:active {
        box-shadow: inset 0 0 0 1px #45475a;
        background-color: #74c7ec;
color: #cdd6f4;
      }

      .control-center .notification-row .notification-background .close-button {
margin: 7px;
padding: 2px;
         border-radius: 6.3px;
color: #1e1e2e;
       background-color: #eba0ac;
      }

      .close-button {
        border-radius: 6.3px;
      }

      .control-center .notification-row .notification-background .close-button:hover {
        background-color: #f38ba8;
color: #1e1e2e;
      }

      .control-center .notification-row .notification-background .close-button:active {
        background-color: #f38ba8;
color: #1e1e2e;
      }

      .control-center .notification-row .notification-background:hover {
        box-shadow: inset 0 0 0 1px #45475a;
        background-color: #7f849c;
color: #cdd6f4;
      }

      .control-center .notification-row .notification-background:active {
        box-shadow: inset 0 0 0 1px #45475a;
        background-color: #74c7ec;
color: #cdd6f4;
      }

      .notification.critical progress {
        background-color: #f38ba8;
      }

      .notification.low progress,
        .notification.normal progress {
          background-color: #89b4fa;
        }

      .control-center-dnd {
        margin-top: 5px;
        border-radius: 8px;
background: #313244;
border: 1px solid #45475a;
        box-shadow: none;
      }

      .control-center-dnd:checked {
background: #313244;
      }

      .control-center-dnd slider {
background: #45475a;
            border-radius: 8px;
      }

      .widget-dnd {
margin: 0px;
        font-size: 1.1rem;
      }

      .widget-dnd > switch {
        font-size: initial;
        border-radius: 8px;
background: #313244;
border: 1px solid #45475a;
        box-shadow: none;
      }

      .widget-dnd > switch:checked {
background: #313244;
      }

      .widget-dnd > switch slider {
background: #45475a;
            border-radius: 8px;
border: 1px solid #6c7086;
      }

      .widget-mpris .widget-mpris-player {
background: #313244;
padding: 7px;
      }

      .widget-mpris .widget-mpris-title {
        font-size: 1.2rem;
      }

      .widget-mpris .widget-mpris-subtitle {
        font-size: 0.8rem;
      }

      .widget-menubar > box > .menu-button-bar > button > label {
        font-size: 3rem;
padding: 0.5rem 2rem;
      }

      .widget-menubar > box > .menu-button-bar > :last-child {
color: #f38ba8;
      }

      .power-buttons button:hover,
        .powermode-buttons button:hover,
        .screenshot-buttons button:hover {
background: #313244;
        }

      .control-center .widget-label > label {
color: #cdd6f4;
       font-size: 2rem;
      }

      .widget-buttons-grid {
        padding-top: 1rem;
      }

      .widget-buttons-grid > flowbox > flowboxchild > button label {
        font-size: 2.5rem;
      }

      .widget-volume {
        padding-top: 1rem;
      }

      .widget-volume label {
        font-size: 1.5rem;
color: #74c7ec;
      }

      .widget-volume trough highlight {
background: #74c7ec;
      }

      .widget-backlight trough highlight {
background: #f9e2af;
      }

      .widget-backlight label {
        font-size: 1.5rem;
color: #f9e2af;
      }

      .widget-backlight .KB {
        padding-bottom: 1rem;
      }

      .image {
        padding-right: 0.5rem;
      }
    '';
  };
}
