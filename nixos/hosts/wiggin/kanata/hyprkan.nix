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
    owner = "mdSlash";
    repo = "hyprkan";
    rev = "10d63fa6afeffd7507b27cc7c1eeb6be83004b50";
    hash = "sha256-Rog6IUZ1slt4Rm67vsNUUBuZY6NLWdr75rwezlMJ3S8=";
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
