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
      "\\xxaccept-line" = "accept-line";
      "\\C-n" = ''"la\xxaccept-line"'';
    };
    variables = {
      editing-mode = "vi";
      show-mode-in-prompt = true;
    };
  };

  home.packages = [
  ];
}
