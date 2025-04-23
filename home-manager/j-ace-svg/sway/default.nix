{
  pkgs,
  lib,
  config,
  ...
}: let
  workspaces = {
    # Numbers done through ╻ (BOX DRAWINGS HEAVY DOWN) and ┃ (BOX DRAWINGS HEAVY VERTICAL)
    "1" = {
      key = "u";
      # name = "1:╻╻╻";
      name = "1:Web";
    };
    "2" = {
      key = "e";
      # name = "2:╻╻┃";
      name = "2:╻╻┃";
    };
    "3" = {
      key = "o";
      # name = "3:╻┃╻";
      name = "3:╻┃╻";
    };
    "4" = {
      key = "a";
      # name = "4:╻┃┃";
      name = "4:╻┃┃";
    };
    "5" = {
      key = "p";
      # name = "5:┃╻╻";
      name = "5:┃╻╻";
    };
    "6" = {
      key = "period";
      # name = "6:┃╻┃";
      name = "6:Messaging";
    };
    "7" = {
      key = "comma";
      # name = "7:┃┃╻";
      name = "7:Game";
    };
    "8" = {
      key = "semicolon";
      # name = "8:┃┃┃";
      name = "8:┃┃┃";
    };
  };
in {
  wayland.windowManager.sway = {
    enable = true;
    package = pkgs.swayfx;
    checkConfig = false; # Fix until nix-community/home-manager#5379 is resolved.
    config = rec {
      #input = {
      #  "*" = {
      #    xkb_layout = "us,us";
      #    xkb_variant = "dvorak,";
      #    xkb_options = "ctrl:nocaps,ctrl:lctrl_meta,shift:both_capslock,grp:rctrl_toggle";
      #  };
      #};
      output = {
        "*" = {
          bg = "${./sway-wallpaper.png} fill";
          #bg = "/run/current-system/sw/share/backgrounds/sway/Sway_Wallpaper_Blue_1920x1080.png fill";
        };
      };
      bars = [
        {
          mode = "dock";
          hiddenState = "hide";
          position = "top";
          workspaceButtons = true;
          workspaceNumbers = false;
          statusCommand = "${pkgs.i3status}/bin/i3status";
          fonts = {
            names = ["monospace"];
            size = 8.0;
          };
          trayOutput = "primary";
          colors = {
            background = "#000000";
            statusline = "#ffffff";
            separator = "#666666";
            focusedWorkspace = {
              border = "#4c7899";
              background = "#285577";
              text = "#ffffff";
            };
            activeWorkspace = {
              border = "#333333";
              background = "#5f676a";
              text = "#ffffff";
            };
            inactiveWorkspace = {
              border = "#333333";
              background = "#222222";
              text = "#888888";
            };
            urgentWorkspace = {
              border = "#2f343a";
              background = "#900000";
              text = "#ffffff";
            };
            bindingMode = {
              border = "#2f343a";
              background = "#900000";
              text = "#ffffff";
            };
          };
        }
      ];
      window = {
        titlebar = false;
        border = 0;
        commands = [
          {
            command = "corner_radius 10";
            criteria = {
              app_id = ".*";
              title = ".*";
              class = ".*";
            };
          }
          {
            command = "blur enable";
            criteria = {
              app_id = ".*"; # get with `swaymsg -t get_tree | grep app_id`
              title = ".*";
              class = ".*";
            };
          }
        ];
      };
      gaps = {
        inner = 10;
      };
      modifier = "Mod4";
      left = "h";
      down = "j";
      up = "k";
      right = "l";
      defaultWorkspace = "workspace number ${workspaces."1".name}";
      assigns = {
        "${workspaces."1".name}" = [{app_id = "^floorp$";}];
        "${workspaces."6".name}" = [{class = "^legcord$";}];
        "${workspaces."7".name}" = [{class = "^steam$";}];
      };
      terminal = "${pkgs.foot}/bin/foot";
      menu = "${pkgs.dmenu}/bin/dmenu_path | ${pkgs.dmenu}/bin/dmenu | ${pkgs.findutils}/bin/xargs swaymsg exec --";
      keybindings = {
        # Workspaces
        # "${modifier}+1" = "workspace number 1";
        # "${modifier}+2" = "workspace number 2";
        # "${modifier}+3" = "workspace number 3";
        # "${modifier}+4" = "workspace number 4";
        # "${modifier}+5" = "workspace number 5";
        # "${modifier}+6" = "workspace number 6";
        # "${modifier}+7" = "workspace number 7";
        # "${modifier}+8" = "workspace number 8";
        # "${modifier}+9" = "workspace number 9";
        # "${modifier}+0" = "workspace number 10";
        # "${modifier}+Shift+1" = "move container to workspace number 1";
        # "${modifier}+Shift+2" = "move container to workspace number 2";
        # "${modifier}+Shift+3" = "move container to workspace number 3";
        # "${modifier}+Shift+4" = "move container to workspace number 4";
        # "${modifier}+Shift+5" = "move container to workspace number 5";
        # "${modifier}+Shift+6" = "move container to workspace number 6";
        # "${modifier}+Shift+7" = "move container to workspace number 7";
        # "${modifier}+Shift+8" = "move container to workspace number 8";
        # "${modifier}+Shift+9" = "move container to workspace number 9";
        # "${modifier}+Shift+0" = "move container to workspace number 10";

        "${modifier}+${workspaces."1".key}" = "workspace number ${workspaces."1".name}";
        "${modifier}+${workspaces."2".key}" = "workspace number ${workspaces."2".name}";
        "${modifier}+${workspaces."3".key}" = "workspace number ${workspaces."3".name}";
        "${modifier}+${workspaces."4".key}" = "workspace number ${workspaces."4".name}";
        "${modifier}+${workspaces."5".key}" = "workspace number ${workspaces."5".name}";
        "${modifier}+${workspaces."6".key}" = "workspace number ${workspaces."6".name}";
        "${modifier}+${workspaces."7".key}" = "workspace number ${workspaces."7".name}";
        "${modifier}+${workspaces."8".key}" = "workspace number ${workspaces."8".name}";
        "${modifier}+Shift+${workspaces."1".key}" = "move container to workspace number ${workspaces."1".name}";
        "${modifier}+Shift+${workspaces."2".key}" = "move container to workspace number ${workspaces."2".name}";
        "${modifier}+Shift+${workspaces."3".key}" = "move container to workspace number ${workspaces."3".name}";
        "${modifier}+Shift+${workspaces."4".key}" = "move container to workspace number ${workspaces."4".name}";
        "${modifier}+Shift+${workspaces."5".key}" = "move container to workspace number ${workspaces."5".name}";
        "${modifier}+Shift+${workspaces."6".key}" = "move container to workspace number ${workspaces."6".name}";
        "${modifier}+Shift+${workspaces."7".key}" = "move container to workspace number ${workspaces."7".name}";
        "${modifier}+Shift+${workspaces."8".key}" = "move container to workspace number ${workspaces."8".name}";

        # Navigation
        "${modifier}+Left" = "focus left";
        "${modifier}+Down" = "focus down";
        "${modifier}+Up" = "focus up";
        "${modifier}+Right" = "focus right";
        "${modifier}+${left}" = "focus left";
        "${modifier}+${down}" = "focus down";
        "${modifier}+${up}" = "focus up";
        "${modifier}+${right}" = "focus right";
        "${modifier}+Shift+Left" = "move left";
        "${modifier}+Shift+Down" = "move down";
        "${modifier}+Shift+Up" = "move up";
        "${modifier}+Shift+Right" = "move right";
        "${modifier}+Shift+${left}" = "move left";
        "${modifier}+Shift+${down}" = "move down";
        "${modifier}+Shift+${up}" = "move up";
        "${modifier}+Shift+${right}" = "move right";

        "${modifier}+b" = "splith";
        "${modifier}+v" = "splitv";
        "${modifier}+f" = "fullscreen toggle";
        "${modifier}+c" = "focus parent";

        "${modifier}+s" = "layout stacking";
        "${modifier}+w" = "layout tabbed";
        "${modifier}+y" = "layout toggle split";

        "${modifier}+Shift+minus" = "move scratchpad";
        "${modifier}+minus" = "scratchpad show";

        "${modifier}+Shift+space" = "floating toggle";
        "${modifier}+space" = "focus mode_toggle";

        "${modifier}+Shift+c" = "reload";
        "${modifier}+Shift+g" = "exec swaynag -t warning -m 'You pressed the exit shortcut. Do you really want to exit sway? This will end your Wayland session.' -b 'Yes, exit sway' 'swaymsg exit'";

        "${modifier}+r" = "mode resize";

        "${modifier}+Shift+q" = "kill";
        "${modifier}+Return" = "exec ${terminal}";
        "${modifier}+d" = "exec ${menu}";
        "Print" = "exec ${pkgs.slurp}/bin/slurp | ${pkgs.grim}/bin/grim -g - $(${pkgs.xdg-user-dirs}/bin/xdg-user-dir PICTURES)/$(date +'screenshot_%Y-%m-%d-%H%M%S.png')";
        "${modifier}+t" = "mode launch";
        "${modifier}+n" = "${pkgs.mako}/bin/makoctl dismiss";
        "F13" = "mode leader";
      };
      modes = {
        leader = {
          "r" = "mode resize";
          "t" = "mode launch";
          "Escape" = "mode default";
          "Return" = "mode default";
          "F13" = "mode default";
        };
        resize = {
          ${left} = "resize shrink width 10 px";
          ${down} = "resize grow height 10 px";
          ${up} = "resize shrink height 10 px";
          ${right} = "resize grow width 10 px";
          "Left" = "resize shrink width 10 px";
          "Down" = "resize grow height 10 px";
          "Up" = "resize shrink height 10 px";
          "Right" = "resize grow width 10 px";
          "Escape" = "mode default";
          "Return" = "mode default";
          "F13" = "mode default";
        };
        launch = {
          "t" = "exec ${pkgs.floorp}/bin/floorp; mode default";
          "Shift+t" = "exec ${pkgs.floorp}/bin/floorp";
          "b" = "exec ${pkgs.bitwarden}/bin/bitwarden; mode default";
          "Shift+b" = "exec ${pkgs.bitwarden}/bin/bitwarden";
          "l" = "exec ${pkgs.legcord}/bin/legcord; mode default";
          "Shift+l" = "exec ${pkgs.legcord}/bin/legcord";
          "s" = "exec ${pkgs.steam}/bin/steam; mode default";
          "Shift+s" = "exec ${pkgs.steam}/bin/steam";
          "n" = "exec ${terminal} nvim; mode default";
          "Shift+n" = "exec ${terminal} nvim";
          "d" = "exec ${terminal} ${pkgs.bc}/bin/dc; mode default";
          "Shift+d" = "exec ${terminal} ${pkgs.bc}/bin/dc";
          "z" = "exec ${config.programs.zathura.package}; mode default";
          "Shift+z" = "exec ${config.programs.zathura.package}";
          "Escape" = "mode default";
          "Return" = "mode default";
          "F13" = "mode default";
        };
      };
    };
    extraConfig = ''
      exec inactive-windows-transparency.py -o 0.9
      exec snap run accountable2you
    '';
  };

  programs.i3status = {
    enable = true;

    modules = {
      ipv6 = {position = 1;};

      "wireless _first_" = {
        position = 2;
        settings = {
          format_up = "W: (%quality at %essid) %ip";
          format_down = "W: down";
        };
      };

      "ethernet _first_" = {
        position = 3;
        settings = {
          format_up = "E: %ip (%speed)";
          format_down = "E: down";
        };
      };

      "battery all" = {
        position = 4;
        settings = {format = "%status %percentage %remaining";};
      };

      "disk /" = {
        position = 5;
        settings = {format = "%avail";};
      };

      load = {
        position = 6;
        settings = {format = "%1min";};
      };

      memory = {
        position = 7;
        settings = {
          format = "%used | %available";
          threshold_degraded = "1G";
          format_degraded = "MEMORY < %available";
        };
      };

      "tztime local" = {
        position = 8;
        settings = {format = "%Y-%m-%d %H:%M:%S";};
      };
    };
  };

  xdg = {
    userDirs = {
      enable = true;
      createDirectories = true;
    };
  };

  home.packages = [
    pkgs.sway-contrib.inactive-windows-transparency
    pkgs.xdg-desktop-portal-wlr
    pkgs.xdg-user-dirs
    pkgs.grim
    pkgs.slurp
    pkgs.wireplumber
    pkgs.wlprop
    pkgs.dipc # Convert wallpapers to ther color schemes
    pkgs.brightnessctl
  ];
}
