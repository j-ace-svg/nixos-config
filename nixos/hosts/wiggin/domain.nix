{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}: {
  /*
    sops = {
    secrets = {
      "cloudflare/email" = {};
      "cloudflare/api_key" = {};
      "cloudflare/domain" = {};
    };
    templates."ddclient-config".content = ''
      ssl=yes

      use=web
      protocol=cloudflare, \
      zone=${config.sops.placeholder."cloudflare/domain"}, \
      login=user@myemail.com, \
      password=${config.sops.placeholder."cloudflare/api_key"} \
      ${config.sops.placeholder."cloudflare/domain"}
    '';
  };
  services.ddclient = {
    enable = true;
    interval = "5min";
    configFile = "${config.sops.templates."ddclient-config".path}";
  };
  */
}
