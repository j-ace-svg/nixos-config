{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}: {
  imports = [
    #./bepasty.nix
    ./deploy.nix
    ./domain.nix
    ./immich.nix
    ./nextcloud.nix
    ./minecraft-server/default.nix
  ];
}
