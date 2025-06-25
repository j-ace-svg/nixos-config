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

  sops = {
    secrets = {
    };
    templates = {
    };
  };

  services.minecraft-servers = {
    enable = true;
    eula = true;

    servers = {
      shakespeare = {
        enable = true;
        package = pkgs.vanillaServers.vanilla-1_21_6;
      };
      # Name for next server (follow order of planets visited by Andrew Wiggin)
      # ganges =
    };
  };
}
