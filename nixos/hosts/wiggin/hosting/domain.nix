{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}: {
  options = {
    local.hosting = {
      domain = lib.mkOption {
        type = lib.types.string;
        description = ''
          What domain to point all externally-facing tools towards
        '';
      };
    };
  };

  config = {
    sops = {
      secrets = {
        "cloudflare/email" = {sopsFile = ./secrets.yaml;};
        "cloudflare/api_key" = {sopsFile = ./secrets.yaml;};
        "cloudflare/domain" = {sopsFile = ./secrets.yaml;};
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

    local.hosting.domain = "philotic.xyz";

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
      virtualHosts."acmechallenge.${config.local.hosting.domain}" = {
        serverAliases = ["*.${config.local.hosting.domain}"];
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
      certs."acmechallenge.${config.local.hosting.domain}" = {
        domain = config.local.hosting.domain;
      };
    };
  };
}
