{
  pkgs,
  inputs,
  ...
}: {
  force = true;
  packages = with inputs.firefox-addons.packages."x86_64-linux"; [
    bitwarden
    ublock-origin
    sponsorblock
    darkreader
    dearrow
    youtube-shorts-block
    firenvim
    gruvbox-dark-theme
  ];
  settings = {
    # Gruvbox dark theme
    "uBlock0@raymondhill.net" = {
      force = true;
      settings = {
        userSettings = {
          uiTheme = "dark";
        };
        selectedFilterLists = [
          "user-filters"
          "ublock-filters"
          "ublock-badware"
          "ublock-privacy"
          "ublock-quick-fixes"
          "ublock-unbreak"
          "easylist"
          "easyprivacy"
          "urlhaus-1"
          "plowe-0"
          "fanboy-cookiemonster"
          "ublock-cookies-easylist"
          "adguard-cookies"
          "ublock-cookies-adguard"
          "fanboy-social"
          "adguard-social"
          "fanboy-thirdparty_social"
          "easylist-chat"
          "easylist-newsletters"
          "easylist-notifications"
          "easylist-annoyances"
          "adguard-mobile-app-banners"
          "adguard-other-annoyances"
          "adguard-popup-overlays"
          "adguard-widgets"
          "ublock-annoyances"
        ];
        userFilters = "! Mar 30, 2025 https://www.youtube.com\\nwww.youtube.com###player:remove()";
      };
    };
  };
}
