{
  pkgs,
  lib,
  config,
  opts,
  ...
}: let
  cfg = config.local.gui;
  endcord = pkgs.callPackage ./endcord.nix {
    inherit (pkgs) fetchFromGitHub python3Packages python3 fetchPypi rustPlatform makeWrapper;
  };
in {
  # All discord clients (well, just 2 at the moment, neither of them actually being discord)
  config = lib.mkIf cfg.enable {
    home.file = {
      ".config/legcord/storage/settings.json" = {
        source = config.lib.file.mkOutOfStoreSymlink "${opts.configPath}/home-manager/j-ace-svg/gui/legcord/settings.json";
      };
    };

    home.packages = [
      pkgs.legcord
      endcord
    ];
  };
}
