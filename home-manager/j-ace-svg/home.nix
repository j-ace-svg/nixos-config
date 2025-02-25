{
  config,
  pkgs,
  inputs,
  ...
}:
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
    ./mpv/default.nix
    ./rnnoise/default.nix
    ./sway/default.nix
    ./newsboat/default.nix
    ./nvim/default.nix
    ./firefox/default.nix
    ./custom-scripts/default.nix
  ];

  # Notification daemon
  services.mako = {
    enable = true;
  };

  programs = {
    # Fuzzy finding
    fzf.enable = true;

    # Automatically enter shell.nix when changing directories
    direnv = {
      enable = true;
      enableBashIntegration = true; # see note on other shells below
      nix-direnv.enable = true;
    };

    bash.enable = true; # see note on other shells below
  };

  home.packages = [
    pkgs.qutebrowser
    pkgs.legcord
    pkgs.zathura # Document viewer/PDF viewer
    pkgs.sxiv # Image viewer
    #pkgs.vimiv-qt # Other image viewer (maybe more vim-like?) #Uncomment later once bug w/ py312 is fixed
    pkgs.vifm
    pkgs.zip
    pkgs.unzip
    pkgs.ripgrep
    pkgs.pavucontrol
    pkgs.sx
    pkgs.hollywood
    pkgs.nuclear
    pkgs.zotify # Spotify downloader
    pkgs.python3Full
    pkgs.libsForQt5.kolourpaint
    pkgs.mov-cli
    pkgs.bitwarden-desktop
    pkgs.bitwarden-cli
    pkgs.gptfdisk # Remove these after sh1mmer stuffs
    pkgs.file # |
    pkgs.ghc
    pkgs.gnumake
    pkgs.nix-init
    pkgs.stack
    pkgs.emacs
    pkgs.cmus
    pkgs.picard
    pkgs.ventoy-full
    pkgs.go-sct

    # Basic Services
    pkgs.libnotify
    pkgs.ueberzugpp

    # Basic Utilities
    #pkgs.cheese
    pkgs.bc
    pkgs.wl-clipboard
    pkgs.ripgrep

    # Media creation
    pkgs.tenacity # The community fork of alacritty after the controversy
    #pkgs.alacritty
    pkgs.musescore # It's actually FOSS! This is a surprise and absolutely a win
    pkgs.lilypond # Text-based music engraving
    pkgs.obs-studio
    pkgs.libsForQt5.kdenlive
    pkgs.inkscape
    pkgs.krita
    pkgs.gimp
    pkgs.lmms
    pkgs.ardour
    pkgs.ffmpeg

    # Browser (adding a chromium one for once in a blue moon when sites require it, booooo :( )
    pkgs.brave

    # Game dev
    pkgs.godot_4
    #pkgs.godot_4-mono

    # Installing postmarketos
    pkgs.android-tools

    # PostmarketOS (and eventually maybe Mobile NixOS?)
    # pkgs.pmbootstrap # (Out of date for some reason? Use `nix run`)

    # Python
    # Uncomment these later, pry once py12 is fixed
    #pkgs.python311Packages.osmnx
    #pkgs.python311Packages.haversine
    #pkgs.python311Packages.geopy

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

    # Minecraft
    pkgs.prismlauncher
    (pkgs.jdk8.overrideAttrs
      (oldAttrs: {meta.priority = 8;}))
    (pkgs.jdk17.overrideAttrs
      (oldAttrs: {meta.priority = 9;}))
    (pkgs.jdk21.overrideAttrs
      (oldAttrs: {meta.priority = 10;}))

    # Voicechanger (custom derivation, pulled from pypi)
    #(pkgs.callPackage ./voicechanger/default.nix { inherit fetchFromGithub lib python3 })
    #(pkgs.callPackage ./voicechanger/default.nix {})
  ];

  # This value determines the Home Manager release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  home.stateVersion = "23.11"; # Did you read the comment?
}
