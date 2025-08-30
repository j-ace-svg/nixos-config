{
  pkgs,
  config,
  ...
}: let
  plann = pkgs.callPackage ./plann.nix {};
in {
  home.packages = [
    pkgs.remind
    pkgs.wyrd
    pkgs.calcurse
    plann
  ];
}
