{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.local.gui;
  colors = import ./colors.nix;
in {
  config = lib.mkIf cfg.enable {
    programs.foot = {
      enable = true;
      server.enable = true;
      settings = {
        main = {
          term = "xterm-256color";
        };
        colors = colors.gruvbox-dark // {alpha = colors.alpha;};
      };
    };

    xdg.mimeApps = {
      enable = true;
      defaultApplications = {
        "inode/directory" = ["foot.desktop"];
      };
    };

    home.packages = [
      pkgs.libsixel
    ];
  };
}
