{pkgs, ...}: {
  wayland.windowManager.sway = {
    enable = true;
    config = rec {
      modifier = "Mod4";
      input = {
        "*" = {
          xkb_layout = "us,us";
          xkb_variant = "dvorak,";
          xkb_options = "ctrl:nocaps,ctrl:lctrl_meta,shift:both_capslock,grp:rctrl_toggle";
        };
      };
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
          workspaceNumbers = true;
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
    };
    extraConfig = ''
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

  home.packages = [
    pkgs.xdg-desktop-portal-wlr
    pkgs.wireplumber
  ];
}
