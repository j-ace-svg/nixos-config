{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.local.gui.media;
in {
  options = {
    local.gui.media.enable = lib.mkOption {
      type = lib.types.bool;
      default = config.local.gui.enable;
      description = ''
        Whether or not to install media playback tools
      '';
    };
  };

  imports = [
    ./beets/default.nix
    ./easyeffects/default.nix
    ./media-creation/default.nix
    ./mpv/default.nix
  ];

  config = lib.mkIf cfg.enable {
    home.packages = [
    ];
  };
}
