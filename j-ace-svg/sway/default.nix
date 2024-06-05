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
          bg = "${./sway-wallpaper.webp} fill";
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

  home.packages = [
    pkgs.xdg-desktop-portal-wlr
    pkgs.wireplumber
  ];
}
