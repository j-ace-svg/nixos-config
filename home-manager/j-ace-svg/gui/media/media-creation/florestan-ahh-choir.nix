{
  lib,
  stdenv,
  pkg-config,
}:
stdenv.mkDerivation rec {
  pname = "florestan-ahh-choir";
  version = "1.3";

  src = builtins.fetchTarball {
    url = "https://dev.nando.audio/_static/sf2/052_Florestan_Ahh_Choir.zip";
    sha256 = "1vkc690b0v4vd5zdsninkawb3gkih40q32b3khl4n20yf5adq4dh";
  };

  nativeBuildInputs = [pkg-config];
  buildInputs = [
  ];

  buildPhase = "";
  installPhase = ''
    install -Dm644 -t "$out/lib/sf2" "$src/052_Florestan_Ahh_Choir.sf2"
  '';

  meta = with lib; {
    homepage = "https://dev.nando.audio/pages/soundfonts.html";
    description = ''"a very realistic and useful mixed choir"'';
  };
}
