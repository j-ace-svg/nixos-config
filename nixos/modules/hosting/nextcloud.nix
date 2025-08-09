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
      enable = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = ''
          Whether or not to run nextcloud on this host
        '';
      };
      subdomain = lib.mkOption {
        type = lib.types.str;
        default = "nextcloud";
        description = ''
          What subdomain to run nextcloud on
        '';
      };
      collaboraSubdomain = lib.mkOption {
        type = lib.types.str;
        default = "docs.${cfg.nextcloud.subdomain}";
        defaultText = lib.literalExpression ''"docs.''${local.hosting.nextcloud.subdomain}"'';
        description = ''
          What subdomain to run collabora (realtime document collaboration) on
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

    services.nextcloud = {
      enable = true;
      package = pkgs.nextcloud31;
      hostName = "${cfg.nextcloud.subdomain}.${cfg.domain}";
      config = {
        adminpassFile = config.sops.secrets."nextcloud/admin_password".path;
        dbtype = "sqlite";
      };
      phpOptions."realpath_cache_size" = "0"; # Don't cache symlink realpaths because they change on rebuild
      extraApps = {
        inherit (config.services.nextcloud.package.packages.apps) contacts calendar tasks richdocuments;
      };
      extraAppsEnable = true;
      https = true;
    };

    services.collabora-online = {
      enable = true;
      port = 9980;
      settings = {
        ssl = {
          enable = false;
          termination = true;
        };
        net = {
          listen = "loopback";
          post_allow.hook = ["::1"];
        };
        storage.wopi = {
          "@allow" = true;
          host = [config.services.nextcloud.hostName];
        };
        server_name = "${cfg.nextcloud.collaboraSubdomain}.${cfg.domain}";
      };
    };

    services.nginx.virtualHosts.${config.services.nextcloud.hostName} = {
      forceSSL = true;
      useACMEHost = "acmechallenge.${cfg.domain}";
      acmeRoot = null;
    };

    services.nginx.virtualHosts.${config.services.collabora-online.settings.server_name} = {
      forceSSL = true;
      useACMEHost = "acmechallenge.${cfg.domain}";
      acmeRoot = null;
      locations."/" = {
        proxyPass = "http://[::1]:${toString config.services.collabora-online.port}";
        proxyWebsockets = true; # Collabora uses websockets
      };
    };
  };
}
