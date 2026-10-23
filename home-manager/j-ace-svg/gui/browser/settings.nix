{opts}: {
  "extensions.autoDisableScopes" = 0;
  "extensions.activeThemeID" = "{eb8c4a94-e603-49ef-8e81-73d3c4cc04ff}";
  "accessibility.typeaheadfind.manual" = false;

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
  # Disable alt menu
  "ui.key.menuAccessKeyFocuses" = false;
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
}
