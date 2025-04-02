{
  pkgs,
  inputs,
  ...
}: {
  programs.floorp = {
    enable = true;
    package = pkgs.floorp;
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
      search = import ./search.nix {inherit pkgs inputs;};

      extensions = import ./extensions.nix {inherit pkgs inputs;};

      settings = {
        "extensions.autoDisableScopes" = 0;
        "extensions.activeThemeID" = "{eb8c4a94-e603-49ef-8e81-73d3c4cc04ff}";

        # Disable first-run stuff
        "browser.aboutwelcome.enabled" = false;
        "trailhead.firstrun.didSeeAboutWelcome" = true;
        "browser.disableResetPrompt" = true;
        "browser.feeds.showFirstRunUI" = false;
        "browser.messaging-system.whatsNewPanel.enabled" = false;
        "browser.rights.3.shown" = true;
        "browser.shell.checkDefaultBrowser" = false;
        "browser.shell.defaultBrowserCheckCount" = 1;
        "browser.startup.homepage_override.mstone" = "ignore";
        "browser.uitour.enabled" = false;
        "browser.bookmarks.restore_default_bookmarks" = false;

        # Disable newtab page junk
        "browser.newtabpage.activity-stream.feeds.topsites" = false;
        "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
        "browser.newtabpage.activity-stream.improvesearch.topSiteSearchShortcuts" = false;

        # Customize newtab page
        "browser.newtabpage.activity-stream.floorp.background.type" = 4;
        "browser.newtabpage.activity-stream.floorp.background.image.path" = "/etc/nixos/home-manager/j-ace-svg/sway/sway-wallpaper.png";

        # Disable telemetry stuff
        "app.shield.optoutstudies.enabled" = false;
        "browser.discovery.enabled" = false;
        "browser.newtabpage.activity-stream.feeds.telemetry" = false;
        "browser.newtabpage.activity-stream.telemetry" = false;
        "browser.ping-centre.telemetry" = false;
        "datareporting.healthreport.service.enabled" = false;
        "datareporting.healthreport.uploadEnabled" = false;
        "datareporting.policy.dataSubmissionEnabled" = false;
        "datareporting.sessions.current.clean" = true;
        "devtools.onboarding.telemetry.logged" = false;
        "toolkit.telemetry.archive.enabled" = false;
        "toolkit.telemetry.bhrPing.enabled" = false;
        "toolkit.telemetry.enabled" = false;
        "toolkit.telemetry.firstShutdownPing.enabled" = false;
        "toolkit.telemetry.hybridContent.enabled" = false;
        "toolkit.telemetry.newProfilePing.enabled" = false;
        "toolkit.telemetry.prompted" = 2;
        "toolkit.telemetry.rejected" = true;
        "toolkit.telemetry.reportingpolicy.firstRun" = false;
        "toolkit.telemetry.server" = "";
        "toolkit.telemetry.shutdownPingSender.enabled" = false;
        "toolkit.telemetry.unified" = false;
        "toolkit.telemetry.unifiedIsOptIn" = false;
        "toolkit.telemetry.updatePing.enabled" = false;
        "extensions.pocket.enabled" = false;
        "middlemouse.paste" = false;

        # Disable fx accounts
        "identity.fxaccounts.enabled" = false;
        # Disable DRM prompt
        "media.gmp-widevinecdm.visible" = false;
        # Disable download popup on completion
        "browser.download.alwaysOpenPanel" = false;
        # Disable password/address/payment method autofill
        "signon.rememberSignons" = false;
        "extensions.formautofill.addresses.enabled" = false;
        "extensions.formautofill.creditCards.enabled" = false;
        # Disable about:config warning
        "browser.aboutConfig.showWarning" = false;
        # Harden
        "privacy.trackingprotection.enabled" = true;
        "dom.security.https_only_mode" = true;
        "privacy.globalprivacycontrol.enabled" = true;
        "privacy.donottrackheader.enabled" = true;
        "privacy.globalprivacycontrol.was_ever_enabled" = true;

        # Layout
        "browser.tabs.tabmanager.enabled" = true;
        "browser.uidensity" = 1;
        "browser.compactmode.show" = true;
        "browser.uiCustomization.state" = builtins.toJSON {
          currentVersion = 20;
          newElementCount = 5;
          dirtyAreaCache = ["nav-bar" "PersonalToolbar" "toolbar-menubar" "TabsToolbar" "widget-overflow-fixed-list"];
          placements = {
            PersonalToolbar = ["personal-bookmarks"];
            TabsToolbar = ["tabbrowser-tabs" "new-tab-button" "alltabs-button"];
            nav-bar = ["back-button" "forward-button" "stop-reload-button" "urlbar-container" "downloads-button" "ublock0_raymondhill_net-browser-action" "_testpilot-containers-browser-action" "reset-pbm-toolbar-button" "unified-extensions-button"];
            toolbar-menubar = ["menubar-items"];
            unified-extensions-area = [];
            widget-overflow-fixed-list = [];
          };
          seen = ["save-to-pocket-button" "developer-button" "ublock0_raymondhill_net-browser-action" "_testpilot-containers-browser-action"];
        };
        "floorp.lepton.interface" = 3;
      };
    };
  };

  xdg = {
    desktopEntries.floorp = {
      name = "Floorp";
      exec = "${pkgs.floorp}/bin/floorp %u";
      terminal = false;
      type = "Application";
      categories = ["Application" "Network" "WebBrowser"];
      mimeType = ["text/html" "text/xml"];
    };

    mimeApps.defaultApplications = {
      "text/html" = ["floorp.desktop"];
      "text/xml" = ["floorp.desktop"];
      "x-scheme-handler/http" = ["floorp.desktop"];
      "x-scheme-handler/https" = ["floorp.desktop"];
    };
  };

  home.packages = [
  ];
}
