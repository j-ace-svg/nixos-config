{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}: {
  imports = [
    ./acme-emailFromEnvironment/default.nix
  ];
  sops = {
    secrets = {
      "nextcloud/admin_password" = {sopsFile = ./secrets.yaml;};
    };
    templates = {
      "nextcloud/secretFile".content = builtins.toJSON {
        trusted_domains = ["nextcloud.${config.sops.placeholder."cloudflare/domain"}"];
      };
      "nextcloud/nginx_extraConfig" = {
        content = ''
          server_name nextcloud.${config.sops.placeholder."cloudflare/domain"};
        '';
        owner = config.services.nginx.user;
      };
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
    hostName = "nextcloud.${config.local.hosting.domain}";
    config = {
      adminpassFile = config.sops.secrets."nextcloud/admin_password".path;
      dbtype = "sqlite";
    };
    secretFile = config.sops.templates."nextcloud/secretFile".path;
    phpOptions."realpath_cache_size" = "0"; # Don't cache symlink realpaths because they change on rebuild
    extraApps = {
      inherit (config.services.nextcloud.package.packages.apps) contacts calendar tasks;
    };
    extraAppsEnable = true;
    https = true;
  };

  services.nginx.virtualHosts.${config.services.nextcloud.hostName} = {
    forceSSL = true;
    useACMEHost = "acmechallenge.${config.local.hosting.domain}";
    acmeRoot = null;
  };

  security.acme.certs."acmechallenge.${config.local.hosting.domain}".extraDomainNames = [config.services.nextcloud.hostName];
}
