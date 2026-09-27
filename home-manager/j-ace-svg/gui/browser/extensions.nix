{
  pkgs,
  inputs,
  lib,
  ...
}: {
  force = true;
  packages = with inputs.firefox-addons.packages."x86_64-linux"; let
    buildFirefoxXpiAddon = lib.makeOverridable (
      {
        stdenv ? pkgs.stdenv,
        fetchurl ? pkgs.fetchurl,
        pname,
        version,
        addonId,
        url,
        sha256,
        meta,
        ...
      }:
        stdenv.mkDerivation {
          name = "${pname}-${version}";

          inherit meta;

          src = fetchurl {inherit url sha256;};

          preferLocalBuild = true;
          allowSubstitutes = true;

          passthru = {
            inherit addonId;
          };

          buildCommand = ''
            dst="$out/share/mozilla/extensions/{ec8030f7-c20a-464f-9b0e-13a3a9e97384}"
            mkdir -p "$dst"
            install -v -m644 "$src" "$dst/${addonId}.xpi"
          '';
        }
    );

    request-control = buildFirefoxXpiAddon {
      pname = "request-control";
      version = "1.15.5";
      addonId = "{1b1e6108-2d88-4f0f-a338-01f9dbcccd6f}";
      url = "https://addons.mozilla.org/firefox/downloads/file/3604499/requestcontrol-1.15.5.xpi";
      sha256 = "sha256-paOqaw26lGuIClp/OfIJfY87a/TTNSS1KwLicUwMI1g=";
      meta = with lib; {
        homepage = "https://github.com/tumpio/requestcontrol";
        description = "An extension for controlling requests.";
        license = licenses.gpl3;
        mozPermissions = [
          "<all_urls>"
          "storage"
          "webNavigation"
          "webRequest"
          "webRequestBlocking"
        ];
        platforms = platforms.all;
      };
    };
  in [
    bitwarden
    ublock-origin
    sponsorblock
    darkreader
    dearrow
    youtube-shorts-block
    firenvim
    gruvbox-dark-theme
    bionic-reader

    request-control
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
