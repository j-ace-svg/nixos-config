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
    inputs.glide.homeModules.default
  ];

  config = lib.mkIf cfg.enable {
    programs.glide-browser = {
      enable = true;
      policies = import ./policies.nix;

      profiles."${profileName}" = {
        search = import ./search.nix {inherit pkgs inputs;};

        extensions = import ./extensions.nix {inherit pkgs inputs lib;};

        settings =
          (import ./settings.nix {inherit opts;})
          // {
          };
      };
    };

    xdg.configFile."glide/glide/${profileName}/handlers.json" = {
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

    xdg.configFile."glide" = {
      recursive = true;
      source = ./glide-config;
    };

    home.packages = [
    ];
  };
}
