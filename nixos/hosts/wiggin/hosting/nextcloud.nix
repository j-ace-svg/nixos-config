{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}: {
  sops = {
    secrets = {
      "nextcloud/admin_password" = {};
    };
  };
  services.nextcloud = {
    enable = true;
    package = pkgs.nextcloud31;
    hostName = "${config.sops.placeholder."cloudflare/domain"}";
    config = {
      adminpassFile = "${config.sops.secrets."nextcloud/admin_password".path}";
      dbtype = "sqlite";
    };
    extraApps = {
      inherit (config.services.nextcloud.package.packages.apps) contacts calendar tasks;
    };
    extraAppsEnable = true;
  };
}
