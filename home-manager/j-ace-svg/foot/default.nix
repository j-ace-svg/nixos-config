{
  pkgs,
  lib,
  ...
}: let
  colors = import ./colors.nix;
in {
  programs.foot = {
    enable = true;
    server = true;
    colors = colors.gruvbox-dark;
  };
}
