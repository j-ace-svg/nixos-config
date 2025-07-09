{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}: {
  imports = [
    ./hosting/default.nix
  ];
}
