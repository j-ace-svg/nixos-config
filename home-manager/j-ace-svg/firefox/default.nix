{
  pkgs,
  inputs,
  ...
}: {
  programs.firefox = {
    enable = true;
    package = pkgs.firefox-beta;
    policies = {
      DontCheckDefaultBrowser = true;
      DisableTelemetry = true;
      DisableFirefoxStudies = true;
      DisablePocket = true;
      #DisableFirefoxScreenshots = true;
      PasswordManagerEnabled = false;
      AutofillAddressEnabled = false;
      AutofillCreditCardEnabled = false;

      #DisplayBookmarksToolbar = "never";
      DisplayMenuBar = "never"; # Previously appeared when pressing alt

      OverrideFirstRunPage = "";
      PictureInPicture.Enabled = false;
      PromptForDownloadLocation = false;

      HardwareAcceleration = true;
      TranslateEnabled = true;

      Homepage.StartPage = "previous-session";

      UserMessaging = {
        UrlbarInterventions = false;
        SkipOnboarding = true;
      };

      FirefoxSuggest = {
        WebSuggestions = false;
        SponsoredSuggestions = false;
        ImproveSuggest = false;
      };

      EnableTrackingProtection = {
        Value = true;
        Cryptomining = true;
        Fingerprinting = true;
      };

      FirefoxHome =
        # Make new tab only show search
        {
          Search = true;
          TopSites = false;
          SponsoredTopSites = false;
          Highlights = false;
          Pocket = false;
          SponsoredPocket = false;
          Snippets = false;
        };
    };

    profiles.j-ace-svg = {
      search = {
        engines = {
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
        default = "DuckDuckGo";
        force = true;
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
