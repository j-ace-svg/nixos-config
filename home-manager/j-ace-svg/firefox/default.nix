{
  pkgs,
  inputs,
  ...
}: {
  programs.firefox = {
    enable = true;
    package = pkgs.firefox-beta;
    policies = {
      DisablePocket = true;
      DisableTelemetry = true;
    };

    profiles.j-ace-svg = {
      search.engines = {
        "Nix Packages" = {
          urls = [
            {
              template = "https://search.nixos.org/packages";
              params = [
                {
                  name = "type";
                  value = "packages";
                }
                {
                  name = "channel";
                  value = "unstable";
                }
                {
                  name = "query";
                  value = "{searchTerms}";
                }
              ];
            }
          ];
          definedAliases = ["ns"];
        };
      };

      extensions = with inputs.firefox-addons.packages."x86_64-linux"; [
        bitwarden
        ublock-origin
        sponsorblock
        darkreader
        dearrow
      ];

      settings = {
        "extensions.autoDisableScopes" = 0;
        "extensions.activeThemeID" = "firefox-compact-dark@mozilla.org";
        "trailhead.firstrun.didSeeAboutWelcome" = true;
      };
    };
  };

  home.packages = [
  ];
}
