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
    rev = "4f12126a5f6c2c466027fa1011447d99d8d5173f";
    hash = "sha256-4ReaXeafUfFR9YAVkRMZTcVFjgRwOgUGoffeYBdyQMA=";
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
