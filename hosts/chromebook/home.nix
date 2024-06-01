{ config, pkgs, inputs, lib, ... }:

let dotfileDirectory = ./../../dotfiles;
in
{
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

        nixpkgs.config = {
            allowUnfree = true;
            vivaldi = {
                enableWideVine = true;
                proprietaryCodecs = true;
            };
        };
    home.packages = with pkgs; [
        tmux
            eza
            zoxide
            ripgrep
            atuin
            lazygit
            gh
            bat
            fzf
            fd
            broot
            tldr
            unzip
            delta
            cargo
            dust
            duf
            bottom
            gping
            neovim

# hyprland stuff
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

# # You can also create simple shell scripts directly inside your
# # configuration. For example, this adds a command 'my-hello' to your
# # environment:
# (pkgs.writeShellScriptBin "my-hello" ''
#   echo "Hello, ${config.home.username}!"
# '')
            ];

    programs.zsh = {
        enable = true;
        autosuggestion.enable = true;
        syntaxHighlighting.enable = true;
        shellAliases = {
            ls = "eza";
            vim = "nvim";
            grep = "rg";
            cat = "bat";
            rb = "~/nixos/rebuildChromebook.sh";
            du = "dust";
            df = "duf";
            vimhome = "nvim ~/nixos/hosts/chromebook/home.nix";
            vimconfig = "nvim ~/nixos/hosts/chromebook/configuration.nix";
        };
        initExtra = ''
            source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
            source ~/.p10k.zsh
            if [[ -n $SSH_CONNECTION ]]; then
                export EDITOR='vim'
            else
                export EDITOR='nvim'
                    fi

                    eval "$(zoxide init --cmd cd zsh)"
                    eval "$(atuin init zsh)"

                    bindkey -v

                    MODE_CURSOR_VIINS="#dce0b1 blinking bar"
                    MODE_CURSOR_REPLACE="blinking underline #8a3129"
                    MODE_CURSOR_VICMD="#5c7a38 blinking block"
                    MODE_CURSOR_SEARCH="#ff00ff steady underline"
                    MODE_CURSOR_VISUAL="$MODE_CURSOR_VICMD steady bar"
                    MODE_CURSOR_VLINE="$MODE_CURSOR_VISUAL #00ffff"
                    '';

        oh-my-zsh = {
            enable = true;
            plugins = [
                "git"
                    "history"
                    "tmux"
                    "vi-mode"
                    "web-search"
                    "ripgrep"
                    "last-working-dir"
                    "history"
                    "gh"
                    "fzf"
                    "fd"
                    "fasd"
            ];
        };
    };


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
                    format-window-separator = " ";
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
        settings = {
            monitor = ",preferred,auto,auto";

# launch apps on startup
            exec-once = "waybar & hyprpaper & mako & hypridle";

# default apps
            "$terminal" = "wezterm";
            "$fileManager" = "dolphin";
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
                gaps_out = "8";
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
                workspace_swipe = "off";
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
#dwindle
                    "$mainMod, P, pseudo,"
                    "$mainMod, space, togglesplit,"
# Move focus with mainMod + arrow keys
                    "$mainMod, h, movefocus, l"
                    "$mainMod, l, movefocus, r"
                    "$mainMod, k, movefocus, u"
                    "$mainMod, j, movefocus, d"
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

# Home Manager is pretty good at managing dotfiles. The primary way to manage
# plain files is through 'home.file'.

    home.file = {
        ".p10k.zsh".source = dotfileDirectory+"/.p10k.zsh";
        ".wezterm.lua".source = dotfileDirectory+"/.wezterm.lua";
        ".config/nvim" = {
            recursive = true;
            source = dotfileDirectory+"/.config/nvim";
        };
        ".tmux.conf".source = dotfileDirectory+"/.tmux.conf";
        ".tmux" = {
            recursive = true;
            source = dotfileDirectory+"/.tmux";
        };
        ".config/waybar/style.css".source = dotfileDirectory+"/.config/waybar/style.css";
        ".config/hypr/hyprlock.conf".source = dotfileDirectory+"/.config/hypr/hyprlock.conf";
        ".config/hypr/hypridle.conf".source = dotfileDirectory+"/.config/hypr/hypridle.conf";
        ".config/mako/config".source = dotfileDirectory+"/.config/mako/config";
    };
# home manager can also manage your environment variables through
# 'home.sessionvariables'. if you don't want to manage your shell through home
# manager then you have to manually source 'hm-session-vars.sh' located at
# either
#
#  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
#
# or
#
#  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
#
# or
#
#  /etc/profiles/per-user/xtremejames1/etc/profile.d/hm-session-vars.sh
#
    home.sessionVariables = {
        editor = "neovim";
    };

#    programs.git = {
#        enable = true;
#        userName  = "James Xiao";
#        userEmail = "xtremejames1@gmail.com";
#    };



# Let Home Manager install and manage itself.
    programs.home-manager.enable = true;
}
