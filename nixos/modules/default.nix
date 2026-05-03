{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}: {
  imports = [
    ./hosting/default.nix
    ./keyboard/default.nix
  ];
}
