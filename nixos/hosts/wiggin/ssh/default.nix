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
      "ssh/authorized_keys/j-ace-svg" = {
        content = ''
          ${config.sops.placeholder."ssh/termux"}
        '';
        path = "${config.users.users.j-ace-svg.home}/.ssh/authorized_keys";
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
