{
  pkgs,
  lib,
  ...
}: {
  home.packages = [
    pkgs.fontforge-gtk
    (pkgs.callPackage ./ninjargon/derivation.nix {inherit pkgs;})
  ];
}
