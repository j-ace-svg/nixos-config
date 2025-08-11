{
  config,
  lib,
  pkgs,
  modulesPath,
  opts,
  ...
}: let
  cfg = config.local.hosting;
in {
  options = {
    local.hosting = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = ''
          Whether or not to enable self-hosted services on this host
        '';
      };

      domain = lib.mkOption {
        type = lib.types.str;
        description = ''
          What domain to point all externally-facing tools towards
        '';
      };

      secretsDir = lib.mkOption {
        type = lib.types.path;
        default = ../../hosts/${config.networking.hostName}/hosting;
        description = ''
          The location of the directory containing sops files with secrets for
          self-hosted services
        '';
      };
    };
  };

  config = lib.mkIf cfg.enable {
    sops = {
      secrets = {
        "cloudflare/email" = {sopsFile = cfg.secretsDir + /secrets.yaml;};
        "cloudflare/api_key" = {sopsFile = cfg.secretsDir + /secrets.yaml;};
        "cloudflare/domain" = {sopsFile = cfg.secretsDir + /secrets.yaml;};
      };
      templates = {
        "ddclient/config".content = ''
          ssl=yes

          cache=/var/lib/ddclient/ddclient.cache
          use=web
          protocol=cloudflare, \
          zone=${config.sops.placeholder."cloudflare/domain"}, \
          password=${config.sops.placeholder."cloudflare/api_key"} \
          ${config.sops.placeholder."cloudflare/domain"}
        '';
        "acme/cert_environmentFile".content = ''
          LEGO_EMAIL=${config.sops.placeholder."cloudflare/email"}
        '';
      };
    };

    services.ddclient = {
      enable = true;
      interval = "5min";
      configFile = "${config.sops.templates."ddclient/config".path}";
    };
    systemd.services.ddclient = {
      after = ["sops-install-secrets.service"];
    };
    networking.firewall = {
      enable = true;
      allowedTCPPorts = [80 443];
    };

    users.users.nginx.extraGroups = ["acme"];
    services.nginx = {
      enable = true;
      virtualHosts."acmechallenge.${cfg.domain}" = {
        serverAliases = ["*.${cfg.domain}"];
        locations."/.well-known/acme-challenge" = {
          root = "/var/lib/acme/acme-challenge";
        };
        locations."/" = {
          return = "301 https://$host$request_uri";
        };
      };
    };

    security.acme = {
      acceptTerms = true;
      defaults = {
        environmentFile = config.sops.templates."acme/cert_environmentFile".path;
        emailFromEnvironment = true;
        webroot = "/var/lib/acme/acme-challenge";
      };
      certs."acmechallenge.${cfg.domain}" = {
        domain = cfg.domain;
        #extraDomainNames = ["*.${cfg.domain}"];
      };
    };
  };
}
