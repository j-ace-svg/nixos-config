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
        color = {
          title = "blue";
          keys = "green";
        };
        separator = ": ";
      };
      modules = [
        "title"
        "separator"
        {
          type = "datetime";
          key = "Date";
          format = "{1}-{3}-{11}";
        }
        {
          type = "datetime";
          key = "Time";
          format = "{14}:{17}:{20}";
        }
      ];
    };
  };
}
