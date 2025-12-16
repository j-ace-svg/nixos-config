{
  pkgs,
  config,
  lib,
  ...
}: let
  cfg = config.local.gui.media;
in {
  config = lib.mkIf cfg.enable {
    programs.beets = {
      enable = true;
      settings = {
        plugins = [
          "fromfilename"
          "musicbrainz"
          "discogs"
          "chroma"
        ];
      };
    };

    home.packages = [
    ];
  };
}
