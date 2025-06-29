{
  lib,
  stdenv,
  pkg-config,
}:
stdenv.mkDerivation rec {
  pname = "the-experience-yamaha-s6";
  version = "1.3";

  src = builtins.fetchTarball {
    url = "https://downloads.pianobook.co.uk/Portal%20Downloads/packs/6068_20220807-052738/The%20Experience%20Yamaha%20S6%20V1.3.zip";
    sha256 = "1vkc690b0v4vd5zdsninkawb3gkih40q32b3khl4n20yf5adq4dh";
  };

  nativeBuildInputs = [pkg-config];
  buildInputs = [
  ];

  buildPhase = "";
  installPhase = ''
    install -Dm444 -t "$out/doc/${pname}/" "$src/Readme.txt"
    install -Dm444 -t "$out/lib/swz" "$src/The Experience Yamaha S6 AB Cardioid V1.3.sfz"
    install -Dm444 -t "$out/lib/swz" "$src/The Experience Yamaha S6 AB Omni V1.3.sfz"
    install -Dm444 -t "$out/lib/swz" "$src/The Experience Yamaha S6 Ambisonic Down V1.3.sfz"
    install -Dm444 -t "$out/lib/swz" "$src/The Experience Yamaha S6 Ambisonic Level V1.3.sfz"
    install -Dm444 -t "$out/lib/swz" "$src/The Experience Yamaha S6 Ambisonic Up V1.3.sfz"
    install -Dm444 -t "$out/lib/swz" "$src/The Experience Yamaha S6 ORTF Hammers V1.3.sfz"
  '';

  meta = with lib; {
    homepage = "https://www.pianobook.co.uk/packs/the-experience-yamaha-s6/";
    description = "Yamaha’s hand built semi concert grand with Performance and Ambisonic/VR perspectives.";
  };
}
