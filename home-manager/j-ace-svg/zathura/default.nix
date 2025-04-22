{
  pkgs,
  lib,
  ...
}: {
  # Document viewer/PDF viewer
  programs.zathura = {
    enable = true;
    options = {
      recolor = true;
      recolor-lightcolor = "#282828";
      recolor-darkcolor = "#ebdbb2";
      default-bg = "rgba(40, 40, 40, 178)"; #B3
      default-fg = "#ebdbb2";
    };
  };

  home.packages = [
  ];
}
