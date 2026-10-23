{
  pkgs,
  inputs,
  config,
  lib,
  opts,
  ...
}: let
  cfg = config.local.gui;
  profileName = "j-ace-svg";
in {
  imports = [
    ./glide.nix
  ];

  config = lib.mkIf cfg.enable {
    programs.floorp = {
      enable = true;
      package = pkgs.floorp-bin;
      policies = import ./policies.nix;

      profiles."${profileName}" = {
        search = import ./search.nix {inherit pkgs inputs;};

        extensions = import ./extensions.nix {inherit pkgs inputs lib;};

        settings =
          (import ./settings.nix {inherit opts;})
          // {
            # Customize newtab page
            "browser.newtabpage.activity-stream.floorp.background.type" = 4;
            "browser.newtabpage.activity-stream.floorp.background.image.path" = "${opts.configPath}/home-manager/j-ace-svg/gui/sway/sway-wallpaper.png";

            "floorp.lepton.interface" = 3;
          };
      };
    };

    home.file.".mozilla/firefox/${profileName}/handlers.json" = {
      force = true;
      text = builtins.toJSON {
        "defaultHandlersVersion" = {};
        "mimeTypes" = {
          "application/pdf" = {
            "action" = 3;
            "extensions" = ["pdf"];
          };
          "image/webp" = {
            "action" = 3;
            "extensions" = ["webp"];
          };
          "image/avif" = {
            "action" = 3;
            "extensions" = ["avif"];
          };
        };
        "schemes" = {
          "mailto" = {
            "stubEntry" = true;
            "handlers" = [
              null
              {
                "name" = "Gmail";
                "uriTemplate" = "https://mail.google.com/mail/?extsrc=mailto&url=%s";
              }
            ];
          };
        };
        "isDownloadsImprovementsAlreadyMigrated" = false;
      };
    };

    home.sessionVariables.BROWSER = "floorp";

    xdg.mimeApps = {
      enable = true;
      defaultApplications = {
        "text/html" = ["floorp.desktop"];
        "text/xml" = ["floorp.desktop"];
        "x-scheme-handler/http" = ["floorp.desktop"];
        "x-scheme-handler/https" = ["floorp.desktop"];
        "x-scheme-handler/about" = ["floorp.desktop"];
        "x-scheme-handler/chrome" = ["floorp.desktop"];
        "x-scheme-handler/unknown" = ["floorp.desktop"];
        "application/x-extension-htm" = ["floorp.desktop"];
        "application/x-extension-html" = ["floorp.desktop"];
        "application/x-extension-shtml" = ["floorp.desktop"];
        "application/xhtml+xml" = ["floorp.desktop"];
        "application/x-extension-xhtml" = ["floorp.desktop"];
        "application/x-extension-xht" = ["floorp.desktop"];
      };
    };

    home.packages = [
    ];
  };
}
