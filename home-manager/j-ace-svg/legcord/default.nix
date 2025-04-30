{
  pkgs,
  lib,
  config,
  ...
}: {
  home.file = {
    ".config/legcord/storage/settings.json" = {
      source = config.lib.file.mkOutOfStoreSymlink ./settings.json;
    };
  };

  home.packages = [
  ];
}
