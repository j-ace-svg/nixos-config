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

  imports = [
    ./sway/default.nix
    ./rnnoise/default.nix
  ];

  # Notification daemon
  services.mako = {
    enable = true;
  };

  home.packages = [
    pkgs.qutebrowser
    #pkgs.alacritty
    pkgs.armcord
    pkgs.zathura # Document viewer/PDF viewer
    pkgs.sxiv # Image viewer
    pkgs.vimiv-qt # Other image viewer (maybe more vim-like?)
    pkgs.zip
    pkgs.unzip
    pkgs.mpv
    pkgs.pavucontrol
    pkgs.sx
    pkgs.hollywood
    pkgs.nuclear
    pkgs.yt-dlp
    pkgs.python3Full
    pkgs.libsForQt5.kolourpaint
    pkgs.mov-cli
    pkgs.bitwarden-desktop
    pkgs.bitwarden-cli
    pkgs.gptfdisk # Remove these after sh1mmer stuffs
    pkgs.file # |
    pkgs.ghc
    pkgs.stack
    pkgs.emacs

    # Basic Services
    pkgs.libnotify

    # Basic Utilities
    pkgs.gnome.cheese
    pkgs.grim
    pkgs.bc
    pkgs.wl-clipboard
    pkgs.ripgrep

    # Media creation
    pkgs.tenacity # The community fork of alacritty after the controversy
    pkgs.obs-studio
    pkgs.libsForQt5.kdenlive
    pkgs.inkscape
    pkgs.krita
    pkgs.gimp
    pkgs.lmms

    # Game dev
    pkgs.godot_4

    # Installing postmarketos
    pkgs.android-tools

    # PostmarketOS (and eventually maybe Mobile NixOS?)
    # pkgs.pmbootstrap # (Out of date for some reason? Use `nix run`)

    # Games
    pkgs.mari0
    pkgs.steamcmd
    #pkgs.steam-tui
    (pkgs.callPackage
      (pkgs.fetchurl {
        url = "https://raw.githubusercontent.com/NixOS/nixpkgs/91a54ff02353ec2591c454c7dcf74db4d703f5fe/pkgs/games/steam-tui/default.nix";
        hash = "sha256-ejgsDfmE3HJMbdHRYNW+TMHDUQsmmc8soRtSl0YczKo=";
      })
      {})

    # Voicechanger (custom derivation, pulled from pypi)
    #(import ./voicechanger/default.nix { inherit buildPythonPackage pkgs fetchurl })
    #./voicechanger/default.nix
  ];

  # This value determines the Home Manager release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  home.stateVersion = "23.11"; # Did you read the comment?
}
