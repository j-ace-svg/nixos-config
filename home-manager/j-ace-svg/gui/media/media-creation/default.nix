{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.local.gui.media;
  updated-dl-librescore = pkgs.callPackage ./updated-dl-librescore.nix {
    inherit (pkgs) python3 cctools;
  };
in {
  imports = [
    ./daw.nix
  ];

  config = lib.mkIf cfg.enable {
    xdg.mimeApps = {
      enable = true;
      associations.added = {
        "audio/*" = ["tenacity.desktop"];
      };
    };

    home.packages = [
      pkgs.libreoffice
      pkgs.tenacity # The community fork of alacritty after the controversy
      #pkgs.alacritty
      pkgs.musescore # It's actually FOSS! This is a surprise and absolutely a win
      pkgs.lilypond # Text-based music engraving
      pkgs.obs-studio
      pkgs.kdePackages.kdenlive
      pkgs.inkscape
      pkgs.krita
      pkgs.gimp
      pkgs.sfizz
      pkgs.ffmpeg
      pkgs.kdePackages.k3b

      #updated-dl-librescore
    ];
  };
}
