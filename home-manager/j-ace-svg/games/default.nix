{
  pkgs,
  lib,
  ...
}: {
  home.file.".local/share/Steam/steamapps/common/Counter-Strike Global Offensive/game/csgo/cfg/autoexec.cfg" = {
    source = ./csgo/autoexec.cfg;
    executable = true;
  };

  home.packages = [
  ];
}
