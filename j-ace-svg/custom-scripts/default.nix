{pkgs, ...}: {
  home.packages = with pkgs; [
    (writeShellScriptBin "you-wouldnt-download-a-person" (builtins.readFile ./you-wouldnt-download-a-person.sh))
  ];
}
