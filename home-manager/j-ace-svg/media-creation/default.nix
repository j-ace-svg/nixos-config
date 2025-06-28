{
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./daw.nix
  ];

  home.packages = [
    pkgs.tenacity # The community fork of alacritty after the controversy
    #pkgs.alacritty
    pkgs.musescore # It's actually FOSS! This is a surprise and absolutely a win
    pkgs.lilypond # Text-based music engraving
    pkgs.obs-studio
    pkgs.libsForQt5.kdenlive
    pkgs.inkscape
    pkgs.krita
    pkgs.gimp
    pkgs.sfizz
    pkgs.ffmpeg
    pkgs.dl-librescore
  ];
}
