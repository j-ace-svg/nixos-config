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
      "\\xxbeginning-of-line_" = "beginning-of-line"; # Commas improve legibility but are also now necessary
      "\\xxkill-line_" = "kill-line"; # Commas improve legibility but are also now necessary
      "\\xxaccept-line_" = "accept-line";
      "\\xxyank_" = "yank";
      "\\xxyank-pop_" = "yank-pop";
      "\\C-n" = ''"\M--\xxkill-line_\xxkill-line_la\xxaccept-line_\xxyank_\xxbeginning-of-line_\xxyank_\xxyank-pop_"'';
    };
    variables = {
    };
  };

  home.packages = [
  ];
}
