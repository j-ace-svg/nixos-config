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
}
