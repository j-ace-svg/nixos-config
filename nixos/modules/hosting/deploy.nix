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
    local.hosting.deploy = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = ''
          Whether or not to set up this host to deploy nix configurations to
          servers (default enabled)
        '';
      };
    };
  };

  config = lib.mkIf cfg.deploy.enable {
    networking.hosts = {
      "philotic.xyz" = ["jane"];
    };
    programs.ssh.extraConfig = ''
      Host jane
        Hostname philotic.xyz
        Port 2222
    '';
  };
}
