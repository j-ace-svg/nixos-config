{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.local.gui;
in {
  config = lib.mkIf cfg.enable {
    services.nextcloud-client = {
      enable = true;
      startInBackground = true;
    };

    home.packages = [
    ];
  };
}
