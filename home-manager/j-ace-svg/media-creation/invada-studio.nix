{
  lib,
  stdenv,
  ladspa-sdk,
  pkg-config,
}:
stdenv.mkDerivation rec {
  pname = "invada-studio";
  version = "0.2.33";

  src = builtins.fetchTarball {
    url = "https://launchpad.net/invada-studio/ladspa/0.3/+download/invada-studio-plugins_0.3.1-nopkg.tar.gz";
    sha256 = "043ybf4nhivki0lb9swg1c9yg6lyx659c1rrbpwxncs3m0cqk5w1";
  };

  patchPhase = ''
    sed -e "s#INSTALL_PLUGINS_DIR''\t=''\t/usr/local#INSTALL_PLUGINS_DIR = $out#" -i Makefile
    sed -e "s#INSTALL_LRDF_DIR''\t=''\t/usr/local#INSTALL_LRDF_DIR = $out#" -i Makefile
  '';

  nativeBuildInputs = [pkg-config];
  buildInputs = [
    ladspa-sdk
  ];

  meta = with lib; {
    homepage = "https://launchpad.net/invada-studio/";
    description = "A set of audio plugins";
    longDescription = ''
      Invada Studio plugins include:
      input module, low pass (mono and stereo), high pass (mono and
      stereo), tube (mono and stereo), compressor (mono and stereo),
      and ER reverb (mono in and sum l+r in)
    '';
    license = licenses.gpl3;
  };
}
