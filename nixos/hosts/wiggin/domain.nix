{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}: {
  sops = {
    secrets = {
      "cloudflare/email" = {};
      "cloudflare/api_key" = {};
      "cloudflare/domain" = {};
    };
    templates."ddclient-config".content = ''
      ssl=yes

      cache=/var/cache/ddclient/ddclient.cache
      use=web
      protocol=cloudflare, \
      zone=${config.sops.placeholder."cloudflare/domain"}, \
      #login=${config.sops.placeholder."cloudflare/email"}, \
      password=${config.sops.placeholder."cloudflare/api_key"} \
      ${config.sops.placeholder."cloudflare/domain"}
    '';
  };
  services.ddclient = {
    enable = true;
    interval = "5min";
    configFile = "${config.sops.templates."ddclient-config".path}";
  };
  systemd.services.ddclient = {
    after = ["sops-install-secrets.service"];
  };
}
