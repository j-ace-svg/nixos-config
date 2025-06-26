{
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./csgo/default.nix
    ./minecraft/default.nix
  ];

  home.packages = [
    pkgs.mari0

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
}
