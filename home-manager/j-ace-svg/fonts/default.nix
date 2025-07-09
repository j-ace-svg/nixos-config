{
  pkgs,
  lib,
  ...
}: {
  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      serif = ["DejaVu Serif"];
      sansSerif = ["DejaVu Sans"];
      monospace = ["DejaVu Sans Mono"];
    };
  };

  home.packages = [
    pkgs.fontforge-gtk
    (pkgs.callPackage ./ninjargon/derivation.nix {inherit pkgs;})
    pkgs.nerd-fonts.dejavu-sans-mono
    pkgs.dejavu_fonts
  ];
}
