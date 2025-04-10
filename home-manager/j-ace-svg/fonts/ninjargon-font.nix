{pkgs}:
pkgs.stdenvNoCC.mkDerivation {
  name = "ninjargon-font";
  dontConfigue = true;
  src = pkgs.fetchzip {
    url = "https://get.fontspace.co/download/family/d23gx/77285098d4f248cfba9a5c194f258fb7/ninjago-alphabet-font.zip";
    sha256 = "sha256-cejY4XtXogtY6HA4N+mYgHdQyIWd1+uVef4+F9Q2uqQ=";
    stripRoot = false;
  };
  installPhase = ''
    mkdir -p $out/share/fonts
    cp -R $src $out/share/fonts/truetype/
  '';
  meta = {description = "The Ninjargon Font Family derivation.";};
}
