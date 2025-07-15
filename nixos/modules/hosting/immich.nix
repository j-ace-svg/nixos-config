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
        type = lib.types.string;
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
      useACMEHost = "acmechallenge.${config.local.hosting.domain}";
      acmeRoot = null;
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
        #inherit (config.services.nginx.virtualHosts."acmechallenge.${config.local.hosting.domain}".locations) "/.well-known/acme-challenge";
      };
    };

    #security.acme.certs."acmechallenge.${config.local.hosting.domain}".extraDomainNames = [config.services.immich.host];
  };
}
