{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.local.gui.media;
in {
  config = lib.mkIf cfg.enable {
    services.easyeffects.enable = true;
  };
}
