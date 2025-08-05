{
  pkgs,
  fetchFromGitHub,
  lib,
  libreoffice,
  calibre,
  md2pdf,
}:
pkgs.stdenvNoCC.mkDerivation {
  name = "zaread";
  dontConfigue = true;

  src = fetchFromGitHub {
    owner = "paoloap";
    repo = "zaread";
    rev = "c2d45e1bbaeb0a637b1747cc89b483f2c6d11cb3";
    hash = "sha256-g4Xb6gGA09/rfv0myzHbc830BwtD37IOYuEIwoOigP8=";
  };

  buildInputs = [
    libreoffice
    calibre
    md2pdf
  ];

  patchPhase = ''
    rm Makefile
    sed -ie '3i PATH="${libreoffice}/bin:${calibre}/bin:${md2pdf}/bin:$PATH"' zaread
  '';

  installPhase = ''
    mkdir -p $out/bin
    install -m 755 $src/zaread $out/bin/
    mkdir -p $out/share/applications
    cp $src/zaread.desktop $out/share/applications/
  '';

  meta = with lib; {
    description = "A (very) lightweight MS Office file reader";
    homepage = "https://github.com/paoloap/zaread";
    license = licenses.gpl3;
  };
}
