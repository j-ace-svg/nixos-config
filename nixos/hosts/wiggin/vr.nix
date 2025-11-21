{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}: {
  services.monado = {
    enable = true;
    defaultRuntime = true;
  };
}
