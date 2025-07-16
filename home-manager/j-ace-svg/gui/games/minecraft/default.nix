{
  pkgs,
  lib,
  ...
}: {
  home.packages = [
    pkgs.prismlauncher
    (pkgs.jdk8.overrideAttrs
      (oldAttrs: {meta.priority = 8;}))
    (pkgs.jdk17.overrideAttrs
      (oldAttrs: {meta.priority = 9;}))
    (pkgs.jdk21.overrideAttrs
      (oldAttrs: {meta.priority = 10;}))

    # Performance
    pkgs.gamemode
    pkgs.mangohud
  ];
}
