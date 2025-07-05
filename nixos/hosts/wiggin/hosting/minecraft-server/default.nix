{
  config,
  lib,
  pkgs,
  modulesPath,
  inputs,
  ...
}: {
  imports = [
    inputs.nix-minecraft.nixosModules.minecraft-servers
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
            value = {sopsFile = ./secrets.yaml;};
          }
        )
        whitelist-count
        ++ builtins.genList (
          num: {
            name = "minecraft-server/whitelist/user-${inc-num-string num}/name";
            value = {sopsFile = ./secrets.yaml;};
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
          "whitelist.json" = config.sops.templates."minecraft-server/whitelist.json".path;
        };
      };
      # Name for next server (follow order of planets visited by Andrew Wiggin)
      # ganges =
    };
  };
}
