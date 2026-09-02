{
  lib,
  stdenv,
  fetchgit,
  autoreconfHook,
  pkg-config,
  autoconf-archive,
  makeWrapper,
  zenity,
  libGL,
  libsndfile,
  lv2,
  libX11,
  libXext,
  libXrandr,
  libXcursor,
}:
stdenv.mkDerivation rec {
  pname = "liquidsfz";
  version = "0.4.1";

  src = fetchgit {
    #owner = "swesterfeld";
    #repo = "liquidsfz";
    url = "https://github.com/swesterfeld/liquidsfz.git";
    #tag = version;
    #rev = "9b6ddb666bda1168fba8a1008743141c1051a990";
    rev = version;
    hash = "sha256-6E3JT/pWQ1p4RsF9zW2rpOEYn8kCUojVHee7JMZ92wY=";
    fetchSubmodules = true;
  };

  /*
    unpackPhase = ''
    runHook preUnpack
    unpackFile $src

    ls -la source/3rdparty
    ls -la source/3rdparty/imgui || true

    runHook postUnpack
  '';
  */

  postPatch = ''
    substituteInPlace lv2/lv2ui.cc \
      --replace-fail '"/usr/bin/zenity"' '"${lib.getExe zenity}"'
  '';

  nativeBuildInputs = [
    autoreconfHook
    pkg-config
    autoconf-archive
    makeWrapper
  ];

  buildInputs = [
    libGL
    libsndfile
    # Only used w/ jack client
    #readline
    #jack2
    lv2

    libX11
    libXext
    libXrandr
    libXcursor
  ];

  configureFlags = ["--without-jack"];

  meta = with lib; {
    homepage = "https://github.com/swesterfeld/liquidsfz";
    description = "SFZ sampler";
    longDescription = ''
      liquidsfz is a free and open source sampler that can load and play .sfz
      files. It can also load and play Hydrogen drumkits. We support JACK and
      LV2.
    '';
    license = licenses.mpl20;
  };
}
