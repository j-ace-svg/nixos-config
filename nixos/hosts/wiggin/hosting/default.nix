{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}: {
  imports = [
    ./domain.nix
    ./immich.nix
    ./nextcloud.nix
    ./minecraft-server/default.nix
  ];
}
