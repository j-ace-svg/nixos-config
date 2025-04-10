{
  pkgs,
  lib,
  ...
}: {
  home.packages = [
    pkgs.fontforge-gtk
    (pkgs.callPackage ./ninjargon-font.nix {inherit pkgs;})
  ];
}
