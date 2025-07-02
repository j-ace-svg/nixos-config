{
  lib,
  fetchFromGitHub,
  buildPythonApplication,
  i3ipc,
}:
buildPythonApplication rec {
  pname = "hyprkan";
  version = "2.1.0";
  pyproject = false;

  src = fetchFromGitHub {
    inherit pname version;
    # owner = "mdSlash"; # Temporarily trying out a feature I added
    owner = "j-ace-svg";
    repo = "hyprkan";
    rev = "fea05abb57317a7df24bde650944e7047f8a469f";
    hash = "sha256-byrlomOdirZd0lEMRQDTatuTsL8Sc0H/iqgPK4+KvZY=";
  };

  dontUnpack = true;
  installPhase = ''
    install -Dm755 "$src/src/${pname}.py" "$out/bin/${pname}"
  '';

  propagatedBuildInputs = [
    i3ipc
  ];
  meta = with lib; {
    description = "App-aware Kanata layer switcher for Linux";
    homepage = "https://github.com/mdSlash/hyprkan";
    license = licenses.mit;
  };
}
