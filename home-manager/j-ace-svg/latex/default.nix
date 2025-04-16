{
  pkgs,
  lib,
  ...
}: {
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
      inherit (pkgs.texlive) scheme-full latexmk;
    })
  ];
}
