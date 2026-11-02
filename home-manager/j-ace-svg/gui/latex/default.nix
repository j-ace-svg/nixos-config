{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.local.gui;
in {
  config = lib.mkIf cfg.enable {
    home.file = {
      ".config/latex/preamble.sty" = {
        source = ./preamble.sty;
      };
      ".config/latex/main.tex" = {
        source = ./main.tex;
      };
    };

    home.packages = [
      (pkgs.texlive.combine {
        inherit (pkgs.texlive) scheme-full latexmk pgf;
      })
      pkgs.poppler-utils

      pkgs.sent # Funnily enough, something that explicitly doesn't use latex, but a generically related purpose
    ];
  };
}
