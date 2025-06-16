{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}: {
  sops = {
    secrets = {
      "ssh/termux" = {sopsFile = ./secrets.yaml;};
    };
    templates = {
      "ssh/authorized_keys".content = ''
        ${config.sops.placeholder."ssh/termux"}
      '';
    };
  };
  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      PermitRootLogin = "no";
      AllowUsers = ["j-ace-svg"];
    };
  };
  networking.firewall.allowedTCPPorts = [22];
}
