{pkgs, ...}:
#let
#  canvasWebApp = pkgs.qutebrowser.override {
#
#  }
#in
{
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.j-ace-svg = import ./j-ace-svg/home.nix;
  };
}
