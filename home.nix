{pkgs, ...}:
#let
#  canvasWebApp = pkgs.qutebrowser.override {
#
#  }
#in
let
  nixosRecentCommitTarball = builtins.fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/0e575a459e4c3a96264e7a10373ed738ec1d708f.tar.gz"; # 2021-09-18
    # to find this, click on "commits" at https://github.com/NixOS/nixpkgs and then follow nose to get e.g. https://github.com/NixOS/nixpkgs/commit/0e575a459e4c3a96264e7a10373ed738ec1d708f, and then change "commit" to "archive" and add ".tar.gz"
  };
in {
  home.username = "j-ace-svg";
  home.homeDirectory = "/home/j-ace-svg";
  programs.home-manager.enable = true;

  # Window manager
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
          bg = "/run/current-system/sw/share/backgrounds/sway/Sway_Wallpaper_Blue_1920x1080.png fill";
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

  # Notification daemon
  services.mako = {
    enable = true;
  };

  home.packages = [
    pkgs.qutebrowser
    pkgs.alacritty
    pkgs.armcord
    pkgs.zathura
    pkgs.zip
    pkgs.unzip
    pkgs.mpv
    pkgs.rnnoise
    pkgs.bc
    pkgs.pavucontrol
    pkgs.sx
    pkgs.hollywood
    pkgs.nuclear
    pkgs.python3Full
    pkgs.libsForQt5.kolourpaint
    pkgs.gptfdisk # Remove these after sh1mmer stuffs
    pkgs.file # |

    pkgs.steamcmd
    #pkgs.steam-tui
    (pkgs.callPackage
      (pkgs.fetchurl {
        url = "https://raw.githubusercontent.com/NixOS/nixpkgs/91a54ff02353ec2591c454c7dcf74db4d703f5fe/pkgs/games/steam-tui/default.nix";
        hash = "sha256-ejgsDfmE3HJMbdHRYNW+TMHDUQsmmc8soRtSl0YczKo=";
      })
      {})
  ];

  # This value determines the Home Manager release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  home.stateVersion = "23.11"; # Did you read the comment?
}
