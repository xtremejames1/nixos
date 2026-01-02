{
  pkgs,
  lib,
  config,
  ...
}: {
  imports = [
    ./screenshot.nix
    ./gtk.nix
  ];

  wayland.windowManager.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    extraSessionCommands = ''
      export XDG_CURRENT_DESKTOP=sway
      export XDG_SESSION_DESKTOP=sway
      export XDG_SESSION_TYPE=wayland
      export MOZ_ENABLE_WAYLAND=1
    '';
    config = rec {
      modifier = "Mod1";
      terminal = "wezterm";
      menu = "rofi -show run";
      keybindings = let
        modifier = config.wayland.windowManager.sway.config.modifier;
        menu = config.wayland.windowManager.sway.config.menu;
        terminal = config.wayland.windowManager.sway.config.terminal;
        calculator = "rofi -show calc -modi calc -no-show-match -no-sort";
        window = "rofi -show window";
        browser = "zen";
        explorer = "wezterm start -- yazi";
      in
        lib.mkOptionDefault {
          "Mod4+B" = "exec ${browser}";
          "Mod4+E" = "exec ${explorer}";
          "Mod4+R" = "exec ${menu}";
          "Mod4+C" = "exec ${calculator}";
          "Mod1+Tab" = "exec ${window}";
          "Mod4+L" = "exec hyprlock";
          "Mod4+Shift+S" = "exec screenshot";
          "Mod1+Shift+Control+H" = "exec swaymsg move workspace to output left";
          "Mod1+Shift+Control+J" = "exec swaymsg move workspace to output down";
          "Mod1+Shift+Control+K" = "exec swaymsg move workspace to output up";
          "Mod1+Shift+Control+L" = "exec swaymsg move workspace to output right";
          "XF86AudioMute" = "exec pamixer -t";
          "XF86AudioRaiseVolume" = "exec pamixer -i 5";
          "XF86AudioLowerVolume" = "exec pamixer -d 5";
          "XF86AudioNext" = "exec playerctl next";
          "XF86AudioPrev" = "exec playerctl previous";
          "Print" = "exec playerctl play-pause";
          "XF86Favorites" = "exec playerctl next";
          "XF86Display" = "exec rofi-network-manager";
          "XF86MonBrightnessUp" = "exec brightnessctl set +5%";
          "XF86MonBrightnessDown" = "exec brightnessctl set 5%-";
          "XF86Assistant" = "exec ${terminal}";
        };
      keycodebindings = {
        "248" = "exec playerctl previous";
      };
      startup = [
        {command = "easyeffects";}
        {command = "wezterm";}
        {command = "mako";}
        # XDG Desktop Portal setup
        {
          command = "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=sway";
          always = false;
        }
        {
          command = "systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP";
          always = false;
        }
      ];
      input = {
        "*" = {
          xkb_layout = "us,us";
          xkb_variant = ",colemak_dh";
          xkb_options = "grp:win_space_toggle";
          repeat_delay = "200";
          repeat_rate = "30";
        };
        "type:touchpad" = {
          natural_scroll = "enabled";
          tap = "enabled"; # enables click-on-tap
          tap_button_map = "lrm"; # tap with 1 finger = left click, 2 fingers = right click, 3 fingers = middle click
          dwt = "enabled"; # disable (touchpad) while typing
          dwtp = "enabled"; # disable (touchpad) while track pointing
          accel_profile = "flat"; # disable mouse acceleration (enabled by default; to set it manually, use "adaptive" instead of "flat")
          pointer_accel = "0.8"; # set mouse sensitivity (between -1 and 1)
          scroll_factor = "0.2"; # set scroll speed (between 0.0 and 1.0)
          drag_lock = "disabled";
        };
        "type:mouse" = {
          accel_profile = "flat"; # disable mouse acceleration (enabled by default; to set it manually, use "adaptive" instead of "flat")
          pointer_accel = "0.8"; # set mouse sensitivity (between -1 and 1)
        };
        "2:10:TPPS/2_IBM_TrackPoint" = {
          dwt = "enabled"; # disable (touchpad) while typing
          accel_profile = "flat"; # disable mouse acceleration (enabled by default; to set it manually, use "adaptive" instead of "flat")
          pointer_accel = "0.18"; # set mouse sensitivity (between -1 and 1)
        };
      };

      output = {
        "*" = {
          bg = "#282828 solid_color";
        };
      };
      gaps = {
        inner = 6;
      };

      bars = [
        {command = "waybar";}
      ];
      colors = {
        focused = {
          background = "#98971a";
          border = "#928374";
          childBorder = "#928374";
          indicator = "#a89984";
          text = "#282828";
        };
        focusedInactive = {
          background = "#3c3836";
          border = "#282828";
          childBorder = "#282828";
          indicator = "#a89984";
          text = "#ebdbb2";
        };
        unfocused = {
          background = "#282828";
          border = "#282828";
          childBorder = "#282828";
          indicator = "#a89984";
          text = "#ebdbb2";
        };
        urgent = {
          background = "#fb4934";
          border = "#928374";
          childBorder = "#928374";
          indicator = "#a89984";
          text = "#ebdbb2";
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

    networkmanagerapplet

    rofi-network-manager
    rofi-calc

    pwvucontrol
    playerctl
    pamixer
    easyeffects

    wl-clipboard
    brightnessctl
    yazi
    anyrun
    ianny
  ];

  programs.rofi = {
    enable = true;
    # package = pkgs.rofi-wayland;
    plugins = with pkgs; [
      rofi-network-manager
      rofi-calc
    ];
    theme = let
      # Use `mkLiteral` for string-like values that should show without
      # quotes, e.g.:
      # {
      #   foo = "abc"; => foo: "abc";
      #   bar = mkLiteral "abc"; => bar: abc;
      # };
      inherit (config.lib.formats.rasi) mkLiteral;
    in {
      "*" = {
        background-color = mkLiteral "#282828";
        foreground-color = mkLiteral "#ebdbb2";
        prompt-color = mkLiteral "#98971a";
        result-color = mkLiteral "#458588";
        placeholder-color = mkLiteral "#fb4934";
        border-color = mkLiteral "#FFFFFF";
        width = 512;
        font = "IosevkaTerm NF Medium 10";
      };

      "inputbar" = {
        padding = mkLiteral "5px 5px";
        children = map mkLiteral ["entry"];
      };

      "textbox" = {
        text-color = mkLiteral "@result-color";
      };

      "prompt" = {
        text-color = mkLiteral "@prompt-color";
      };

      "entry" = {
        placeholder = "run";
        placeholder-color = mkLiteral "@placeholder-color";
        text-color = mkLiteral "@prompt-color";
        blink = true;
        cursor-width = 4;
      };

      "textbox-prompt-colon" = {
        expand = false;
        str = ":";
        # margin = mkLiteral "0px 0em 0em 0em";
        text-color = mkLiteral "@prompt-color";
      };
      "element" = {
        padding = mkLiteral "3px";
        highlight = mkLiteral "bold underline";
      };
      "element-text" = {
        text-color = mkLiteral "@foreground-color";
        background-color = mkLiteral "transparent";
      };
      "element selected" = {
        background-color = mkLiteral "#d79921";
      };
      "element alternate" = {
        background-color = mkLiteral "#3c3836";
      };
    };
  };

  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        disable_loading_bar = true;
        grace = 1;
        hide_cursor = false;
        no_fade_in = true;
      };

      animations = {
        enabled = false;
      };

      input-field = [
        {
          size = "200, 30";
          position = "0, -80";
          monitor = "";
          dots_center = true;
          fade_on_empty = false;
          font_family = "IosevkaTerm NF Medium 15";
          font_color = "rgb(ebdbb2)";
          inner_color = "rgb(1d2021)";
          outer_color = "rgb(3c3836)";
          check_color = "rgb(b8bb26)";
          fail_color = "rgb(fb4934)";
          outline_thickness = 5;
          placeholder_text = "password...";
          fail_text = "authentication failed";
          shadow_passes = 0;
          rounding = 0;
        }
      ];

      background = [
        {
          color = "rgb(282828)";
        }
      ];
      auth = {
        # Fingerprint options with quoted attribute names
        "fingerprint:enabled" = true;
        "fingerprint:ready_message" = "Scan fingerprint to unlock";
        "fingerprint:present_message" = "Scanning fingerprint";
        "fingerprint:retry_delay" = 250;
      };
    };
  };

  services.swayidle = {
    enable = true;
    events = {
      lock = "${pkgs.hyprlock}/bin/hyprlock";
      before-sleep = "${pkgs.hyprlock}/bin/hyprlock";
    };
  };

  # Cursors
  # https://nixos.wiki/wiki/Cursor_Themes

  # home.file.".icons/default".source = "${pkgs.posy-cursors}/share/icons/Posy_Cursor";
  home.file.".icons/default".source = "${pkgs.apple-cursor}/share/icons/macOS";

  home.file = {
    ".config/waybar/style.css".source = config.dotfiles.directory + "/.config/waybar/style.css";
    ".config/mako/config".source = config.dotfiles.directory + "/.config/mako/config";
    ".config/anyrun" = {
      recursive = true;
      source = config.dotfiles.directory + "/.config/anyrun";
    };
    ".config/yazi" = {
      recursive = true;
      source = config.dotfiles.directory + "/.config/yazi";
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
        modules-right = ["pulseaudio" "sway/language" "network" "cpu" "memory" "power-profiles-daemon" "battery" "tray" "clock"];
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
        "sway/language" = {
          format = "{}";
          on-click = "swaymsg input type:keyboard xkb_switch_layout next";
        };
        tray = {
          icon-size = 21;
          spacing = 10;
        };
        clock = {
          format = "{:%d%b%Y %T}";
          interval = 1;
          # format-alt = "{:%Y-%m-%d}";
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
          on-click-right = "nm-applet";
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
          on-click-right = "pwvucontrol";
        };
      };
    };
  };

  services.mako = {
    enable = true;
  };
}
