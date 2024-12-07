{
  lib,
  python3,
  fetchFromGitHub,
}:
python3.pkgs.buildPythonApplication rec {
  pname = "pyvoicechanger";
  version = "unstable-2020-04-24";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "juancarlospaco";
    repo = "pyvoicechanger";
    rev = "8ee07887165d129e89bb2461071674534be02d2e";
    hash = "sha256-I+SLPC9ZFfFlm1ApJUgoYIcuTjvTYscQ68tJqVNCgdA=";
  };

  build-system = [
    python3.pkgs.setuptools
    python3.pkgs.wheel
    python3.pkgs.pyqt5
  ];

  pythonImportsCheck = [
    "pyvoicechanger"
  ];

  meta = {
    description = "Real Time Microphone Voice Changer Python 3.6+ App. Works with On-Line Games and VideoConferences";
    homepage = "https://github.com/juancarlospaco/pyvoicechanger";
    license = lib.licenses.gpl3Only;
    maintainers = with lib.maintainers; [];
    mainProgram = "pyvoicechanger";
  };
}
