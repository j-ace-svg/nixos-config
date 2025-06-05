{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}: {
  imports = [
    ./domain.nix
    ./nextcloud.nix
  ];
}
