{
  pkgs,
  lib,
  config,
  opts,
  ...
}: {
  home.file = {
    ".config/legcord/storage/settings.json" = {
      source = config.lib.file.mkOutOfStoreSymlink "${opts.configPath}/home-manager/j-ace-svg/legcord/settings.json";
    };
  };

  home.packages = [
  ];
}
