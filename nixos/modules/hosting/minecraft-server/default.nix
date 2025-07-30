{
  config,
  lib,
  pkgs,
  modulesPath,
  inputs,
  ...
}: let
  cfg = config.local.hosting;
in {
  options = {
    local.hosting.minecraft-server = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = ''
          Whether or not to run minecraft servers on this host
        '';
      };
      secretsDir = lib.mkOption {
        type = lib.types.path;
        default = cfg.secretsDir + /minecraft-server;
        description = ''
          The location of the directory containing sops files with secrets for
          minecraft servers
        '';
      };
    };
  };

  imports = [
    inputs.nix-minecraft.nixosModules.minecraft-servers
  ];

  config = {
    assertions = [
      {
        /*
        Directly enforce cfg.enable rather than using `->` because the
        assertion is part of the conditional configuration
        */
        assertion = cfg.enable;
        message = "local.hosting.minecraft-server.enable requires local.hosting.enable";
      }
    ];
    nixpkgs.overlays = [inputs.nix-minecraft.overlay];

    sops = let
      whitelist-count = 4;
      inc-num-string = x: builtins.toString (x + 1);
    in {
      secrets =
        builtins.listToAttrs (
          builtins.genList (
            num: {
              name = "minecraft-server/whitelist/user-${inc-num-string num}/uuid";
              value = {sopsFile = cfg.minecraft-server.secretsDir + /secrets.yaml;};
            }
          )
          whitelist-count
          ++ builtins.genList (
            num: {
              name = "minecraft-server/whitelist/user-${inc-num-string num}/name";
              value = {sopsFile = cfg.minecraft-server.secretsDir + /secrets.yaml;};
            }
          )
          whitelist-count
        )
        // {
        };
      templates = {
        "minecraft-server/whitelist.json" = {
          content = builtins.toJSON (
            builtins.genList (
              num: {
                "uuid" = config.sops.placeholder."minecraft-server/whitelist/user-${inc-num-string num}/uuid";
                "name" = config.sops.placeholder."minecraft-server/whitelist/user-${inc-num-string num}/name";
              }
            )
            whitelist-count
          );
          owner = config.services.minecraft-servers.user;
        };
      };
    };

    services.minecraft-servers = {
      enable = true;
      eula = true;

      servers = {
        shakespeare = {
          enable = true;
          package = pkgs.vanillaServers.vanilla-1_21_7;
          openFirewall = true;

          serverProperties = {
            server-port = 25565;
            motd = "Self-hosted by yours truly!";
          };

          files = {
            #"whitelist.json" = config.sops.templates."minecraft-server/whitelist.json".path;
          };
        };
        # Name for next server (follow order of planets visited by Andrew Wiggin)
        # ganges =
      };
    };
  };
}
