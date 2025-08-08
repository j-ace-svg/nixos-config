{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}: let
  cfg = config.local.hosting;
in {
  imports = [
  ];

  config = lib.mkIf cfg.immich.enable {
    services.immich.mediaLocation = "/srv/hdd/immich";
  };
}
