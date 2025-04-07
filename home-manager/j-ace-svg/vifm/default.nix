{
  pkgs,
  lib,
  ...
}: {
  programs.vifm = {
    enable = true;
    extraConfig = builtins.readFile ./vifmrc;
  };

  home.file.".config/vifm/scripts" = {
    source = ./scripts;
    executable = true;
  };

  home.packages = [
    pkgs.libsixel
  ];
}
