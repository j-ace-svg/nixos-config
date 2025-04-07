{
  pkgs,
  lib,
  ...
}: let
  colors = import ./colors.nix;
in {
  programs.foot = {
    enable = true;
    server.enable = true;
    settings = {
      colors = colors.gruvbox-dark // {alpha = colors.alpha;};
    };
  };
}
