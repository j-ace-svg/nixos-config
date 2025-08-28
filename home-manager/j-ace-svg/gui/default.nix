{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.local.gui;
in {
  options = {
    local.gui.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = ''
        Whether or not to install graphical interface and applications
      '';
    };
  };

  imports = [
    ./calendar/default.nix
    ./easyeffects/default.nix
    ./floorp/default.nix
    ./fonts/default.nix
    ./foot/default.nix
    ./games/default.nix
    ./latex/default.nix
    ./legcord/default.nix
    ./media-creation/default.nix
    ./mpv/default.nix
    ./nextcloud-client/default.nix
    ./sway/default.nix
    ./zathura/default.nix
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
      pkgs.zotify # Spotify downloader
      pkgs.libsForQt5.kolourpaint
      pkgs.bitwarden-desktop
      pkgs.picard
      pkgs.go-sct

      # Basic Services
      pkgs.libnotify
      pkgs.ueberzugpp

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
