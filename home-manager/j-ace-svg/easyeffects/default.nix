{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.local.gui;
in {
  config = lib.mkIf cfg.enable {
    services.easyeffects.enable = true;
  };
}
