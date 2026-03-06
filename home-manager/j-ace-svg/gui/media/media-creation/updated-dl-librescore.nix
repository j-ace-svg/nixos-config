{
  lib,
  stdenv,
  buildNpmPackage,
  fetchFromGitHub,
  fetchpatch,
  python3,
  cctools,
}:
buildNpmPackage rec {
  pname = "dl-librescore";
  version = "0.35.39"; # Modified from original

  src = fetchFromGitHub {
    owner = "LibreScore";
    repo = "dl-librescore";
    rev = "v${version}";
    hash = "sha256-DZ8PTRMpFGzjbaw/CJ6CZPEazcB3RUd1Gzs/zloqJ8M="; # Modified from original
  };

  npmDepsHash = "sha256-s2bsr2bXuE4gCtQN6uhqxJ247zbOeZpXhwUn/hMKxWU="; # Modified from original

  patches = [
    # https://github.com/LibreScore/dl-librescore/pull/144
    (fetchpatch {
      name = "update-pdfkit.patch";
      url = "https://github.com/LibreScore/dl-librescore/commit/3694697d2d3f3f59ca32ee962999b3dd22c81de7.patch";
      hash = "sha256-ikEJNwKMDWpWBQnS3ur76vZqF+zRI6D5d0AyLDdreJY=";
    })
  ];

  makeCacheWritable = true;

  nativeBuildInputs =
    [
      python3
    ]
    ++ lib.optionals stdenv.hostPlatform.isDarwin [
      cctools
    ];

  meta = {
    description = "Download sheet music";
    homepage = "https://github.com/LibreScore/dl-librescore";
    license = lib.licenses.mit;
    mainProgram = "dl-librescore";
    maintainers = [];
  };
}
