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
        mkLiteralT = str: mkLiteral (str + "99");
      in {
        /**
        * Based on Arthur and Gruvbox dark builtin themes
        * https://github.com/davatorium/rofi/tree/next/themes
        */

        "*" = {
          # Default Arthur colors
          /*
          foreground = mkLiteral "#ffeedd";
          backlight = mkLiteral "#ccffeedd";
          background-color = mkLiteral "transparent";
          dark = mkLiteral "#1c1c1c";
          # Black
          black = mkLiteral "#3d352a";
          lightblack = mkLiteral "#554444";
          tlightblack = mkLiteral "#554444cc";
          tdarkblack = mkLiteral "#1c1c1ccc";
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
          */

          # Gruvbox dark colors
          gruvbox-dark-bg = mkLiteral "#282828";
          gruvbox-dark-fg = mkLiteral "#ebdbb2";
          gruvbox-dark-red-dark = mkLiteral "#cc241d";
          gruvbox-dark-red-light = mkLiteral "#fb4934";
          gruvbox-dark-green-dark = mkLiteral "#98971a";
          gruvbox-dark-green-light = mkLiteral "#b8bb26";
          gruvbox-dark-yellow-dark = mkLiteral "#d79921";
          gruvbox-dark-yellow-light = mkLiteral "#fabd2f";
          gruvbox-dark-blue-dark = mkLiteral "#458588";
          gruvbox-dark-tblue-dark = mkLiteralT "#458588";
          gruvbox-dark-blue-light = mkLiteral "#83a598";
          gruvbox-dark-tblue-light = mkLiteralT "#83a598";
          gruvbox-dark-purple-dark = mkLiteral "#b16286";
          gruvbox-dark-purple-light = mkLiteral "#d3869b";
          gruvbox-dark-aqua-dark = mkLiteral "#689d6a";
          gruvbox-dark-aqua-light = mkLiteral "#8ec07c";
          gruvbox-dark-orange-dark = mkLiteral "#d65d0e";
          gruvbox-dark-orange-light = mkLiteral "#fe8019";
          gruvbox-dark-grey-dark = mkLiteral "#928374";
          gruvbox-dark-grey-light = mkLiteral "#a89984";

          gruvbox-dark-bg0-hard = mkLiteral "#1d2021";
          gruvbox-dark-tbg0-hard = mkLiteralT "#1d2021";
          gruvbox-dark-bd0 = mkLiteral "#282828";
          gruvbox-dark-bg0-soft = mkLiteral "#32302f";
          gruvbox-dark-bg1 = mkLiteral "#3c3836";
          gruvbox-dark-bg2 = mkLiteral "#504945";
          gruvbox-dark-tbg2 = mkLiteralT "#504945";
          gruvbox-dark-bg3 = mkLiteral "#665c54";
          gruvbox-dark-bg4 = mkLiteral "#7c6f64";
          gruvbox-dark-fg4 = mkLiteral "#a89984";
          gruvbox-dark-fg3 = mkLiteral "#bdae93";
          gruvbox-dark-fg2 = mkLiteral "#d5c4a1";
          gruvbox-dark-fg1 = mkLiteral "#ebdbb2";
          gruvbox-dark-fg0 = mkLiteral "#fbf1c7";

          foreground = mkLiteral "@gruvbox-dark-fg1";
          backlight = mkLiteral "@gruvbox-dark-tblue-light";
          background-color = mkLiteral "transparent";
          dark = mkLiteral "@gruvbox-dark-bg0-hard";
          # Black
          black = mkLiteral "@gruvbox-dark-bg1";
          lightblack = mkLiteral "@gruvbox-dark-bg2";
          tlightblack = mkLiteral "@gruvbox-dark-tbg2";
          tdarkblack = mkLiteral "@gruvbox-dark-tbg0-hard";
          #
          # Red
          red = mkLiteral "@gruvbox-dark-red-dark";
          lightred = mkLiteral "@gruvbox-dark-red-light";
          #
          # Green
          green = mkLiteral "@gruvbox-dark-green-dark";
          lightgreen = mkLiteral "@gruvbox-dark-green-light";
          #
          # Yellow
          yellow = mkLiteral "@gruvbox-dark-yellow-dark";
          lightyellow = mkLiteral "@gruvbox-dark-yellow-light";
          #
          # Blue
          blue = mkLiteral "@gruvbox-dark-blue-dark";
          tblue = mkLiteral "@gruvbox-dark-tblue-dark";
          lightblue = mkLiteral "@gruvbox-dark-blue-light";
          #
          # Magenta
          magenta = mkLiteral "@gruvbox-dark-purple-dark";
          lightmagenta = mkLiteral "@gruvbox-dark-purple-light";
          #
          # Cyan
          tcyan = mkLiteral "@tblue";
          #
          # White
          white = mkLiteral "@gruvbox-dark-fg3";
          lightwhite = mkLiteral "@gruvbox-dark-fg";
          #
          # Bold, Italic, Underline
          highlight = mkLiteral "underline bold #ffffff";

          transparent = mkLiteral "rgba(0,0,0,0)";
          #font = "Source Code Pro 10";
          font = "Kode Mono 10";
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
          background-color = mkLiteral "@tdarkblack";
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
      pkgs.kode-mono
    ];
  };
}
