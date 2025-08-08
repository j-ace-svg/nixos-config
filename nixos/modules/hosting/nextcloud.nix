{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}: let
  cfg = config.local.hosting;
in {
  options = {
    local.hosting.nextcloud = {
      subdomain = lib.mkOption {
        type = lib.types.str;
        default = "nextcloud";
        description = ''
          What subdomain to run nextcloud on
        '';
      };
      enable = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = ''
          Whether or not to run nextcloud on this host
        '';
      };
      secretsDir = lib.mkOption {
        type = lib.types.path;
        default = cfg.secretsDir;
        description = ''
          The location of the directory containing sops files with secrets for
          nextcloud
        '';
      };
    };
  };

  imports = [
    ./acme-emailFromEnvironment/default.nix
  ];

  config = lib.mkIf cfg.nextcloud.enable {
    assertions = [
      {
        /*
        Directly enforce cfg.enable rather than using `->` because the
        assertion is part of the conditional configuration
        */
        assertion = cfg.enable;
        message = "local.hosting.nextcloud.enable requires local.hosting.enable";
      }
    ];

    sops = {
      secrets = {
        "nextcloud/admin_password" = {sopsFile = cfg.nextcloud.secretsDir + /secrets.yaml;};
      };
      templates = {
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
      hostName = "${cfg.nextcloud.subdomain}.${config.local.hosting.domain}";
      config = {
        adminpassFile = config.sops.secrets."nextcloud/admin_password".path;
        dbtype = "sqlite";
      };
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
  };
}
