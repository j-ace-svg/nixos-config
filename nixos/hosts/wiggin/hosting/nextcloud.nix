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
    templates."nextcloud/secretFile".content = builtins.toJSON {
      trusted_domains = [config.sops.placeholder."cloudflare/domain"];
    };
  };
  /*
    systemd.paths."nextcloud-secretFile-watcher" = {
    wantedBy = ["multi-user.target"];
    before = [
      "phpfpm-nextcloud.service"
    ];
    pathConfig = {
      PathModified = config.sops.templates."nextcloud/secretFile".path;
    };
  };
  systemd.services."nextcloud-secretFile-watcher" = {
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "systemctl restart phpfpm-nextcloud.service";
    };
  };
  */
  services.nextcloud = {
    enable = true;
    package = pkgs.nextcloud31;
    hostName = "localhost";
    config = {
      adminpassFile = config.sops.secrets."nextcloud/admin_password".path;
      dbtype = "sqlite";
    };
    secretFile = config.sops.templates."nextcloud/secretFile".path;
    phpOptions."realpath_cache_size" = "0";
    extraApps = {
      inherit (config.services.nextcloud.package.packages.apps) contacts calendar tasks;
    };
    extraAppsEnable = true;
  };
  networking.firewall.allowedTCPPorts = [80 443];
}
