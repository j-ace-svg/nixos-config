{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}: {
  imports = [
  ];
  sops = {
    secrets = {
    };
    templates = {
    };
  };

  services.immich = {
    enable = true;
    openFirewall = true;
    host = "immich.${config.local.hosting.domain}";
  };
}
