{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}: {
  imports = [
    ./deploy.nix
    ./domain.nix
    ./immich.nix
    ./nextcloud.nix
    ./minecraft-server/default.nix
  ];
}
