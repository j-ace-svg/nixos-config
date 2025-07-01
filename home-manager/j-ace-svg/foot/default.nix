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

  xdg.mimeApps.defaultApplications = {
    "text/html" = ["floorp.desktop"];
    "inode/directory" = ["foot.desktop"];
  };

  home.packages = [
    pkgs.libsixel
  ];
}
