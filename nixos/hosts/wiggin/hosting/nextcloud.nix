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
      "nextcloud/admin_password" = {};
    };
    templates = {
      "nextcloud/secretFile".content = builtins.toJSON {
        trusted_domains = ["nextcloud.${config.sops.placeholder."cloudflare/domain"}"];
      };
      "nextcloud/nginx_extraConfig".content = ''
        server_name nextcloud.${config.sops.placeholder."cloudflare/domain"};
      '';
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
    hostName = "nextcloud.localhost";
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
    https = true;
  };

  services.nginx.virtualHosts.${config.services.nextcloud.hostName} = {
    extraConfig = ''
      include ${config.sops.templates."nextcloud/nginx_extraConfig".path}
    '';
    forceSSL = true;
    useACMEHost = "acmechallenge.localhost";
    acmeRoot = null;
  };

  security.acme.certs."acmechallenge.localhost".extraDomainNames = ["nextcloud.$cert_domain"];
}
