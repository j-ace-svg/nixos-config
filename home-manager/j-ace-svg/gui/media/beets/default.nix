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
          "chroma"
        ];
        directory = "~/Music";
        import = {
          write = "yes";
          copy = "no";
          move = "no";
        };
      };
    };

    home.packages = [
    ];
  };
}
