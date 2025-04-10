{
  pkgs,
  lib,
  ...
}: {
  home.packages = [
    pkgs.fontforge
    (pkgs.callPackage ./ninjargon-font.nix {inherit pkgs;})
  ];
}
