{
  pkgs,
  config,
  lib,
  ...
}: let
  cfg = config.local.gui;
in {
  config = lib.mkIf cfg.enable {
    xdg.configFile."pipewire/pipewire.conf.d/99-input-denoising.conf" = {
      enable = true;
      text = builtins.readFile ./99-input-denoising.conf;
    };

    home.packages = [
      pkgs.rnnoise
    ];
  };
}
