{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.local.gui;
in {
  imports = [
    ./csgo/default.nix
    ./minecraft/default.nix
  ];

  config = lib.mkIf cfg.enable {
    home.packages = [
      pkgs.mari0
      pkgs.dolphin-emu

      pkgs.steamcmd
      pkgs.steam-tui
      /*
      (pkgs.callPackage
      (pkgs.fetchurl {
        url = "https://raw.githubusercontent.com/NixOS/nixpkgs/91a54ff02353ec2591c454c7dcf74db4d703f5fe/pkgs/games/steam-tui/default.nix";
        hash = "sha256-ejgsDfmE3HJMbdHRYNW+TMHDUQsmmc8soRtSl0YczKo=";
      })
      {})}
      */
    ];
  };
}
