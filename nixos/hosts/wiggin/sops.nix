{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}: {
  sops = {
    age = {
      keyFile = "/root/.config/sops/age/key.txt";
    };
    defaultSopsFile = ./secrets.yaml;
  };
}
