{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.local.gui;
in {
  config = lib.mkIf cfg.enable {
    fonts.fontconfig = {
      enable = true;
      defaultFonts = {
        serif = ["DejaVu Serif"];
        sansSerif = ["DejaVu Sans" "DejaVuSansM Nerd Font Propo" "Hack Nerd Font Propo"];
        monospace = ["DejaVuSansM Nerd Font Mono" "DejaVuSansM Nerd Font" "Hack Nerd Font Mono"];
      };
    };

    home.packages = [
      pkgs.fontforge-gtk
      (pkgs.callPackage ./ninjargon/derivation.nix {inherit pkgs;})
      pkgs.nerd-fonts.hack
      pkgs.nerd-fonts.dejavu-sans-mono
      pkgs.dejavu_fonts
      pkgs.texlivePackages.cm
    ];
  };
}
