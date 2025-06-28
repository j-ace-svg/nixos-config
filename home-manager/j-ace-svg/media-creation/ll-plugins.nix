{
  lib,
  stdenv,
  boost,
  cairomm,
  gtkmm2,
  libjack2,
  libsndfile,
  libsamplerate,
  lv2,
  lv2-cpp-tools,
  pkg-config,
}:
stdenv.mkDerivation rec {
  pname = "ll-plugins";
  version = "0.2.33";

  src = builtins.fetchTarball {
    url = "https://download.savannah.nongnu.org/releases/ll-plugins/ll-plugins-0.2.33.tar.bz2";
    sha256 = "0xinv30wf92gyx4qizqf5mxslnbccx7982b5r7yzldi30k2w4xnl";
  };

  patchPhase = ''
    sed -e "s#prefix = /usr/local#prefix = $out#" -i Makefile.template
  '';

  nativeBuildInputs = [pkg-config];
  buildInputs = [
    boost
    cairomm
    gtkmm2
    libjack2
    libsndfile
    libsamplerate
    lv2
    lv2-cpp-tools
  ];

  meta = with lib; {
    homepage = "https://ll-plugins.nongnu.org/";
    description = "A small collection of LV2 plugins and a host that runs them";
    longDescription = ''
      ll-plugins includes:
      basic arpeggiator, control2midi, klaviatur, math-constants,
      math-functions, peak meter, rudolf 556, sineshaper, and Elven (a
      host)
    '';
    license = licenses.gpl3;
  };
}
