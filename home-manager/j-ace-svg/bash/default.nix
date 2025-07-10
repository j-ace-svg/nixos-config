{pkgs, ...}: {
  programs.bash = {
    enable = true;
    shellAliases = {
      la = "ls -A";
    };
  };

  programs.readline = {
    enable = true;
    bindings = {
      "\\xxkill-whole-line " = "kill-whole-line"; # Spaces improve legibility but are also now necessary
      "\\C-u" = ''"\xxkill-whole-line"'';
      "\\xxaccept-line " = "accept-line";
      "\\xxyank " = "yank";
      "\\xxyank-pop " = "yank-pop";
      "\\C-n" = ''"\xxkill-whole-line la\xxaccept-line \xxyank-pop"'';
    };
    variables = {
      editing-mode = "vi";
      show-mode-in-prompt = true;
    };
  };

  home.packages = [
  ];
}
