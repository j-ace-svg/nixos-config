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
    local.hosting.immich = {
      subdomain = lib.mkOption {
        type = lib.types.str;
        default = "immich";
        description = ''
          What subdomain to run immich on
        '';
      };

      enable = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = ''
          Whether or not to run immich on this host
        '';
      };
    };
  };

  imports = [
  ];

  config = lib.mkIf cfg.immich.enable {
    assertions = [
      {
        /*
        Directly enforce cfg.enable rather than using `->` because the
        assertion is part of the conditional configuration
        */
        assertion = cfg.enable;
        message = "local.hosting.immich.enable requires local.hosting.enable";
      }
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
    };

    services.nginx.virtualHosts."${cfg.immich.subdomain}.${cfg.domain}" = {
      forceSSL = true;
      useACMEHost = "acmechallenge.${cfg.domain}";
      acmeRoot = "/var/lib/acme/acme-challenge";
      extraConfig = ''
        # Increase max upload size (duplicated from the config for `/`, maybe that will help?)
        client_max_body_size 50000M;
      '';
      locations = {
        "/" = {
          proxyPass = "http://${config.services.immich.host}:${toString config.services.immich.port}";
          proxyWebsockets = true;
          recommendedProxySettings = true;
          extraConfig = ''
            client_max_body_size 50000M;
            proxy_read_timeout   600s;
            proxy_send_timeout   600s;
            send_timeout         600s;
          '';
        };
      };
    };

    security.acme.certs."acmechallenge.${cfg.domain}".extraDomainNames = ["${cfg.immich.subdomain}.${cfg.domain}"];
  };
}
