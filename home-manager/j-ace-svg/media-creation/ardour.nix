{
  pkgs,
  lib,
  ...
}: {
  imports = [
  ];

  home.packages = [
    pkgs.ardour
  ];
}
