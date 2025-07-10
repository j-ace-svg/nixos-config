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
      "\\xxkill-whole-line_" = "kill-whole-line"; # Commas improve legibility but are also now necessary
      "\\C-u" = ''"\xxkill-whole-line_"'';
      "\\xxaccept-line_" = "accept-line";
      "\\xxyank_" = "yank";
      "\\xxyank-pop_" = "yank-pop";
      "\\C-n" = ''"\xxkill-whole-line_la\xxaccept-line_ \xxkill-whole-line_\xxyank_\xxyank-pop_"'';
    };
    variables = {
    };
  };

  home.packages = [
  ];
}
