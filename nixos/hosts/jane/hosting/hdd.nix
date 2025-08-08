{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}: {
  fileSystems."/srv/hdd" = {
    device = "/dev/disk/by-label/storage-hdd";
    fsType = "ext4";
    options = ["noatime"];
  };
}
