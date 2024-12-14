{
  lib,
  python3,
  fetchPypi,
}:
python3.pkgs.buildPythonApplication rec {
  pname = "pyvoicechanger";
  version = "1.5.0";
  pyproject = true;

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-+7sDr0t4bDFvdJeJWp61ibaw8cRjJBc3DYslwuibbmg=";
    extension = "zip";
  };

  build-system = [
    python3.pkgs.setuptools
    python3.pkgs.wheel
  ];

  pythonImportsCheck = [
    "pyvoicechanger"
  ];

  meta = {
    description = "Real Time Microphone Voice Changer";
    homepage = "https://pypi.org/project/pyvoicechanger/";
    license = lib.licenses.gpl3Only;
    maintainers = with lib.maintainers; [];
    mainProgram = "pyvoicechanger";
  };
}
