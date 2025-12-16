{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.local.gui.media;
in {
  options = {
    local.gui.media.enable = lib.mkOption {
      type = lib.types.bool;
      default = config.local.gui.enable;
      description = ''
        Whether or not to install media playback tools
      '';
    };
  };

  imports = [
    ./beets/default.nix
    ./easyeffects/default.nix
    ./media-creation/default.nix
    ./mpv/default.nix
  ];

  config = lib.mkIf cfg.enable {
    # Notification daemon
    services.mako = {
      enable = true;
    };

    home.packages = [
      pkgs.qutebrowser
      pkgs.sxiv # Image viewer
      #pkgs.vimiv-qt # Other image viewer (maybe more vim-like?) #Uncomment later once bug w/ py312 is fixed
      pkgs.pavucontrol
      pkgs.sx
      pkgs.nuclear
      pkgs.kdePackages.kolourpaint
      pkgs.bitwarden-desktop
      pkgs.picard
      pkgs.go-sct

      # Basic Services
      pkgs.libnotify
      pkgs.ueberzugpp
      pkgs.soteria # PolicyKit authentication (gui app needs sudo)

      # Browser (adding a chromium one for once in a blue moon when sites require it, booooo :( )
      pkgs.brave

      # Messaging
      pkgs.signal-desktop

      # Game dev
      pkgs.godot_4
      #pkgs.godot_4-mono

      # Voicechanger (custom derivation, pulled from pypi)
      #(pkgs.callPackage ./voicechanger/default.nix { inherit fetchFromGithub lib python3 })
      #(pkgs.callPackage ./voicechanger/default.nix {})
    ];
  };
}
