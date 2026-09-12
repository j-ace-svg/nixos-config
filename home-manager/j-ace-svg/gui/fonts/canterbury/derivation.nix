{pkgs}:
pkgs.stdenvNoCC.mkDerivation {
  name = "canterbury-font";
  dontConfigue = true;
  src = pkgs.fetchzip {
    #url = "https://www.1001fonts.com/download/canterbury.zip";
    url = "file://${./canterbury.zip}";
    sha256 = "sha256-cejY4XtXogtY6HA4N+mYgHdQyIWd1+uVef4+F9Q2uqQ=";
    stripRoot = false;
  };
  installPhase = ''
    mkdir -p $out/share/fonts
    cp -R $src $out/share/fonts/truetype/
  '';
  meta = {description = "The Canterbury derivation.";};
}
