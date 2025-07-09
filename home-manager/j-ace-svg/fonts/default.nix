{
  pkgs,
  lib,
  ...
}: {
  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      serif = ["DejaVu Serif"];
      sansSerif = ["DejaVuSansM Nerd Font Propo" "DejaVu Sans"];
      monospace = ["DejaVuSansM Nerd Font Mono"];
    };
  };

  home.packages = [
    pkgs.fontforge-gtk
    (pkgs.callPackage ./ninjargon/derivation.nix {inherit pkgs;})
    pkgs.nerd-fonts.dejavu-sans-mono
    pkgs.dejavu_fonts
  ];
}
