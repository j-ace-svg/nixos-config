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
      "ssh/wiggin" = {sopsFile = ./secrets.yaml;};
      "ssh/delphiki" = {sopsFile = ./secrets.yaml;};
    };
    templates = {
      "ssh/authorized_keys/j-ace-svg" = {
        content = ''
          ${config.sops.placeholder."ssh/termux"}
          ${config.sops.placeholder."ssh/wiggin"}
          ${config.sops.placeholder."ssh/delphiki"}
        '';
        path = "${config.users.users.j-ace-svg.home}/.ssh/authorized_keys";
        owner = config.users.users.j-ace-svg.name;
      };
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
