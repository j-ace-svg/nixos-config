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
    ./minecraft-server/default.nix
  ];
}
