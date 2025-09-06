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
      whitelist-num-players = {
        shakespeare = lib.mkOption {
          type = lib.types.int;
          default = 0;
          description = ''
            The number of players in the whitelist for the shakespeare server (0 is no whitelist)
          '';
        };
        ganges = lib.mkOption {
          type = lib.types.int;
          default = 0;
          description = ''
            The number of players in the whitelist for the ganges server (0 is no whitelist)
          '';
        };
      };
    };
  };

  imports = [
    inputs.nix-minecraft.nixosModules.minecraft-servers
  ];

  config = lib.mkIf cfg.minecraft-server.enable {
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
      inherit (cfg.minecraft-server) whitelist-num-players;
      inc-num-string = x: builtins.toString (x + 1);
      gen-server-secrets = servername:
        builtins.listToAttrs (
          builtins.genList (
            num: {
              name = "minecraft-server/whitelist/${servername}/user-${inc-num-string num}/uuid";
              value = {sopsFile = cfg.minecraft-server.secretsDir + /secrets.yaml;};
            }
          )
          whitelist-num-players.${servername}
          ++ builtins.genList (
            num: {
              name = "minecraft-server/whitelist/${servername}/user-${inc-num-string num}/name";
              value = {sopsFile = cfg.minecraft-server.secretsDir + /secrets.yaml;};
            }
          )
          whitelist-num-players.${servername}
        );
      gen-whitelist = servername: {
        "minecraft-server/${servername}/whitelist.json" = {
          content = builtins.toJSON (
            builtins.genList (
              num: {
                "uuid" = config.sops.placeholder."minecraft-server/whitelist/${servername}/user-${inc-num-string num}/uuid";
                "name" = config.sops.placeholder."minecraft-server/whitelist/${servername}/user-${inc-num-string num}/name";
              }
            )
            whitelist-num-players.${servername}
          );
          owner = config.services.minecraft-servers.user;
        };
      };
    in {
      secrets =
        gen-server-secrets "shakespeare"
        // gen-server-secrets "ganges"
        // {
        };
      templates =
        gen-whitelist "shakespeare"
        // gen-whitelist "ganges"
        // {
        };
    };

    services.minecraft-servers = {
      enable = true;
      eula = true;

      servers = {
        shakespeare = {
          enable = true;
          package = pkgs.vanillaServers.vanilla-1_21_8;
          openFirewall = true;

          serverProperties = {
            server-port = 25565;
            motd = "Self-hosted by yours truly!";
          };

          files = {
            #"whitelist.json" = lib.mkIf (cfg.minecraft-server.whitelist-num-players.shakespeare > 0) config.sops.templates."minecraft-server/shakespeare/whitelist.json".path;
          };
        };
        ganges = {
          enable = true;
          package = pkgs.vanillaServers.vanilla-1_21_8;
          openFirewall = true;

          serverProperties = {
            server-port = 25566;
            motd = "Self-hosted by yours truly!";
          };

          files = {
            "whitelist.json" = lib.mkIf (cfg.minecraft-server.whitelist-num-players.ganges > 0) config.sops.templates."minecraft-server/ganges/whitelist.json".path;
          };
        };
        # Name for next server (follow order of planets visited by Andrew Wiggin)
        # helvetica - DO NOT USE (the only failed human colony in the series)
        # sorelledolce
      };
    };

    /*
      services.nginx.streamConfig = ''
      server {
        server_name ganges.${cfg.domain}
        listen 0.0.0.0:25565; # Default MC server port
        listen [::1]:25565; # Default MC server port
        proxy_pass localhost:${builtins.toString config.services.minecraft-servers.servers.ganges.serverProperties.server-port};
      }
    '';
    */
  };
}
