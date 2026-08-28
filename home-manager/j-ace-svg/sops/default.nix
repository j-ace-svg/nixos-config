{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.local.sops;
in {
  options = {
    local.sops.sshKeyPaths = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = ["${config.home.homeDirectory}/.ssh/sops_ed25519"];
      description = ''
        Paths to attempt to use to decrypt secrets for home-manager sops.
      '';
    };
  };

  config = {
    sops = {
      age = {
        sshKeyPaths = cfg.sshKeyPaths;
      };
      defaultSopsFile = ../secrets.yaml;
    };

    home.packages = [
    ];
  };
}
