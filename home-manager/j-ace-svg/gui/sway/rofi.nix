{
  pkgs,
  lib,
  config,
  opts,
  ...
}: let
  cfg = config.local.gui;
in {
  config = lib.mkIf cfg.enable {
    programs.rofi = {
      enable = true;
      #theme = "arthur";
      theme = let
        inherit (config.lib.formats.rasi) mkLiteral;
      in {
        /**
        * ROFI Color theme
        * User: Qball
        * Copyright: Dave Davenport
        */

        "*" = {
          foreground = mkLiteral "#ffeedd";
          backlight = mkLiteral "#ccffeedd";
          background-color = mkLiteral "transparent";
          dark = mkLiteral "#1c1c1c";
          # Black
          black = mkLiteral "#3d352a";
          lightblack = mkLiteral "#554444";
          tlightblack = mkLiteral "#554444cc";
          #
          # Red
          red = mkLiteral "#cd5c5c";
          lightred = mkLiteral "#cc5533";
          #
          # Green
          green = mkLiteral "#86af80";
          lightgreen = mkLiteral "#88cc22";
          #
          # Yellow
          yellow = mkLiteral "#e8ae5b";
          lightyellow = mkLiteral "#ffa75d";
          #
          # Blue
          blue = mkLiteral "#6495ed";
          lightblue = mkLiteral "#87ceeb";
          #
          # Magenta
          magenta = mkLiteral "#deb887";
          lightmagenta = mkLiteral "#996600";
          #
          # Cyan
          cyan = mkLiteral "#b0c4de";
          tcyan = mkLiteral "#ccb0c4de";
          lightcyan = mkLiteral "#b0c4de";
          #
          # White
          white = mkLiteral "#bbaa99";
          lightwhite = mkLiteral "#ddccbb";
          #
          # Bold, Italic, Underline
          highlight = mkLiteral "underline bold #ffffff";

          transparent = mkLiteral "rgba(0,0,0,0)";
          font = "Source Code Pro 10";
        };
        window = {
          location = mkLiteral "center";
          anchor = mkLiteral "center";
          transparency = "real";
          padding = mkLiteral "10px";
          border = mkLiteral "0px";
          border-radius = mkLiteral "10px";
          color = mkLiteral "@magenta";
          background-color = mkLiteral "@transparent";
          spacing = mkLiteral "0";
          children = mkLiteral "[mainbox]";
          orientation = mkLiteral "horizontal";
        };
        mainbox = {
          spacing = mkLiteral "0";
          children = mkLiteral "[ inputbar, message, listview ]";
        };
        message = {
          border-color = mkLiteral "@foreground";
          border = mkLiteral "0px 2px 2px 2px";
          #    border-radius = mkLiteral "10px";
          padding = mkLiteral "5";
          background-color = mkLiteral "@tcyan";
        };
        message = {
          font = "Source Code Pro 8";
          color = mkLiteral "@black";
        };
        inputbar = {
          color = mkLiteral "@lightgreen";
          padding = mkLiteral "11px";
          background-color = mkLiteral "@tlightblack";
          border = mkLiteral "2px 2px 2px 2px";
          border-radius = mkLiteral "15px 15px 0px 0px";
          border-color = mkLiteral "@foreground";
          font = "Source Code Pro 18";
        };
        "entry,prompt,case-indicator" = {
          text-font = mkLiteral "inherit";
          text-color = mkLiteral "inherit";
        };
        prompt = {
          margin = mkLiteral "0px 0.3em 0em 0em ";
        };
        listview = {
          padding = mkLiteral "8px";
          border-radius = mkLiteral "0px 0px 15px 15px";
          border-color = mkLiteral "@foreground";
          border = mkLiteral "0px 2px 2px 2px";
          background-color = mkLiteral "#1c1c1ccc";
          dynamic = mkLiteral "false";
          lines = mkLiteral "10";
        };
        element = {
          padding = mkLiteral "3px";
          vertical-align = mkLiteral "0.5";
          #    border = mkLiteral "2px";
          border-radius = mkLiteral "4px";
          background-color = mkLiteral "transparent";
          color = mkLiteral "@foreground";
          font = mkLiteral "inherit";
        };
        element-text = {
          background-color = mkLiteral "inherit";
          text-color = mkLiteral "inherit";
        };
        "element selected.normal" = {
          background-color = mkLiteral "@blue";
        };
        "element normal active" = {
          foreground = mkLiteral "@lightblue";
        };
        "element normal urgent" = {
          foreground = mkLiteral "@lightred";
        };
        "element alternate normal" = {
        };
        "element alternate active" = {
          foreground = mkLiteral "@lightblue";
        };
        "element alternate urgent" = {
          foreground = mkLiteral "@lightred";
        };
        "element selected active" = {
          background-color = mkLiteral "@lightblue";
          foreground = mkLiteral "@dark";
        };
        "element selected urgent" = {
          background-color = mkLiteral "@lightred";
          foreground = mkLiteral "@dark";
        };
        "element normal normal" = {
        };
        vertb = {
          expand = mkLiteral "false";
          children = mkLiteral "[ dummy0, mode-switcher, dummy1  ]";
        };
        "dummy0,  dummy1" = {
          expand = mkLiteral "true";
        };
        mode-switcher = {
          expand = mkLiteral "false";
          orientation = mkLiteral "vertical";
          spacing = mkLiteral "0px";
          border = mkLiteral "0px 0px 0px 0px";
        };
        button = {
          font = "FontAwesome 22";
          padding = mkLiteral "6px";
          border = mkLiteral "2px 0px 2px 2px";
          border-radius = mkLiteral "4px 0px 0px 4px";
          background-color = mkLiteral "@tlightblack";
          border-color = mkLiteral "@foreground";
          color = mkLiteral "@foreground";
          horizontal-align = mkLiteral "0.5";
        };
        "button selected normal" = {
          color = mkLiteral "@dark";
          border = mkLiteral "2px 0px 2px 2px";
          background-color = mkLiteral "@backlight";
          border-color = mkLiteral "@foreground";
        };
        error-message = {
          expand = mkLiteral "true";
          background-color = mkLiteral "red";
          border-color = mkLiteral "darkred";
          border = mkLiteral "2px";
          padding = mkLiteral "1em";
        };
      };
    };

    home.packages = [
      pkgs.source-code-pro
    ];
  };
}
