{
  pkgs,
  lib,
  ...
}: {
  programs.fastfetch = {
    enable = true;
    settings = {
      logo = {
        source = ./aperature-nix.txt;
      };
      display = {
        size = {
          binaryPrefix = "si";
        };
        separator = ": ";
      };
      modules = [
        "title"
        "separator"
        "os"
        "host"
        "kernel"
        "uptime"
        "packages"
        "shell"
        "display"
        "de"
        "wm"
        "wmtheme"
        "theme"
        "icons"
        "font"
        "cursor"
        "terminal"
        "terminalfont"
        "cpu"
        "gpu"
        "memory"
        "swap"
        "disk"
        "localip"
        "battery"
        "poweradapter"
        "locale"
        "break"
        "colors"
      ];
    };
  };
}
