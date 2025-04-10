{
  pkgs,
  lib,
  ...
}: {
  home.packages = [
    (pkgs.callPackage ./ninjargon-font.nix {inherit pkgs;})
  ];
}
