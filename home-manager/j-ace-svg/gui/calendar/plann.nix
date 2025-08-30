{
  lib,
  python3,
  fetchFromGitHub,
  nixosTests,
}:
python3.pkgs.buildPythonApplication rec {
  pname = "plann";
  version = "1.0.0";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "tobixen";
    repo = "plann";
    rev = "v${version}";
    hash = "sha256-WJ7uSYk/esMTjNGAXkjSfqBoxbkOv28tL+PjFc3fwVk=";
  };

  build-system = with python3.pkgs; [
    setuptools
  ];

  dependencies = with python3.pkgs; [
    caldav
    tzlocal
    click
    pyyaml
    sortedcontainers
  ];

  # tests require networking
  doCheck = false;

  passthru.tests = {
    inherit (nixosTests) radicale;
  };

  meta = with lib; {
    description = "Command-line CalDav client";
    homepage = "https://github.com/tobixen/calendar-cli";
    license = licenses.gpl3Plus;
    mainProgram = "plann";
  };
}
