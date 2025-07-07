{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}: {
  imports = [
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
    host = "immich.${config.local.hosting.domain}";
  };

  services.nginx.virtualHosts.${config.services.immich.host} = {
    #forceSSL = true;
    #useACMEHost = "acmechallenge.${config.local.hosting.domain}";
    #acmeRoot = null;
    locations = {
      "/" = {
        proxyPass = "http://[::1]:${toString config.services.immich.port}";
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
}
