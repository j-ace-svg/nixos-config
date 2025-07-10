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
      "\\xxbackward-char_" = "backward-char";
      "\\xxdelete-char_" = "delete-char";
      "\\xxbackward-delete-char_" = "backward-delete-char";
      "\\xxkill-line_" = "kill-line";
      "\\xxaccept-line_" = "accept-line";
      "\\xxyank_" = "yank";
      "\\xxyank-pop_" = "yank-pop";
      "\\C-n" = ''" \e-\xxkill-line_ \xxbackward-char_\xxkill-line_la\xxaccept-line_\xxyank_\xxbeginning-of-line_\xxdelete-char_\xxyank_\xxyank-pop_\xxbackward-delete-char_"'';
    };
    variables = {
    };
  };

  home.packages = [
  ];
}
