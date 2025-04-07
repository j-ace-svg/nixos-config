{
  pkgs,
  lib,
  ...
}: {
  programs.vifm = {
    enable = true;
    extraConfig = builtins.readFile ./vifmrc;
  };

  home.file.".config/vifm/scripts".source = ./scripts;

  home.packages = [
    pkgs.libsixel
  ];
}
