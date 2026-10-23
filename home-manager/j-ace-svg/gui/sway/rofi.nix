{
  pkgs,
  lib,
  config,
  opts,
  ...
}: let
  cfg = config.local.gui;
in {
  config = lib.mkIf cfg.enable {
    programs.rofi = {
      enable = true;
      theme = "arthur";
    };

    home.packages = [
    ];
  };
}
