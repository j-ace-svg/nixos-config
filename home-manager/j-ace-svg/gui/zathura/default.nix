{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.local.gui;
in {
  config = lib.mkIf cfg.enable {
    # Document viewer/PDF viewer
    programs.zathura = {
      enable = true;
      options = {
        recolor = true;
        recolor-lightcolor = "#282828";
        recolor-darkcolor = "#ebdbb2";
        default-bg = "rgba(15.625%, 15.625%, 15.625%, 0.7)"; #B3
        default-fg = "#ebdbb2";
      };
      mappings = {
        "R" = "set recolor";
      };
    };

    home.packages = [
    ];
  };
}
