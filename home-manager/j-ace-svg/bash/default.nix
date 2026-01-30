{
  pkgs,
  config,
  lib,
  ...
}: {
  programs.bash = {
    enable = true;
    shellAliases = {
      la = "ls -A";
      susops = "sudo SOPS_AGE_KEY=\"$(sudo cat /run/secrets.d/age-keys.txt)\" sops";
    };
  };

  programs.readline = {
    enable = true;
    bindings = let
      sub = command: "\\ex${command}\\C-m"; # Function to make substitutable shortcuts for builtin funs
      beginning-of-line = sub "beginning-of-line"; # Commas improve legibility but are also now necessary
      backward-char = sub "backward-char";
      delete-char = sub "delete-char";
      backward-delete-char = sub "backward-delete-char";
      kill-line = sub "kill-line";
      accept-line = sub "accept-line";
      yank = sub "yank";
      yank-pop = sub "yank-pop";
      silent = command: ''" \e-${kill-line} ${backward-char}${kill-line}${command}${accept-line}${yank}${beginning-of-line}${delete-char}${yank}${yank-pop}${backward-delete-char}"'';
    in {
      # User-facing bindings
      "\\C-n" = silent "la";
      "\\C-p" = silent "cd ..";
      "\\C-u" = "kill-whole-line";
      "\\e\\C-w" = "shell-backward-kill-word";
    };
    variables = {
    };
  };

  home.packages = [
  ];
}
