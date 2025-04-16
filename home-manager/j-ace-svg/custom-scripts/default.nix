{pkgs, ...}: {
  home.packages = with pkgs; [
    (writeShellScriptBin "you-wouldnt-download-a-person" (builtins.readFile ./you-wouldnt-download-a-person.sh))
    (writeShellScriptBin "reset-touchpad" (builtins.readFile ./reset-touchpad.sh))
    (writeShellScriptBin "latex-gen" (builtins.readFile ./latex-gen.sh))
  ];
}
