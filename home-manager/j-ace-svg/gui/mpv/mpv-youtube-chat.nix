{
  fetchFromGitHub,
  buildLua,
  lib,
  unstableGitUpdater,
}:
buildLua {
  pname = "mpv-youtube-chat";
  version = "master";

  src = fetchFromGitHub {
    owner = "BanchouBoo";
    repo = "mpv-youtube-chat";
    rev = "4b8d6d5d3ace40d467bc0ed75f3af2a1aefce161";
    hash = "sha256-uZC7iDYqLUuXnqSLke4j6rLoufc/vFTE6Ehnpu//dxY=";
  };

  scriptPath = "main.lua";

  passthru.updateScript = unstableGitUpdater {};

  meta = with lib; {
    description = "Displays chat replays for past Youtube livestreams";
    homepage = "https://github.com/BanchouBoo/mpv-youtube-chat";
    license = licenses.mit;
  };
}
