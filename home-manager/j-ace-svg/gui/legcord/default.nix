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
    home.file = {
      ".config/legcord/storage/settings.json" = {
        source = config.lib.file.mkOutOfStoreSymlink "${opts.configPath}/home-manager/j-ace-svg/legcord/settings.json";
      };
    };

    home.packages = [
      pkgs.legcord
    ];
  };
}
