{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}: {
  imports = [
    ./immich.nix
    ./hdd.nix
  ];
}
