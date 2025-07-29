{
  pkgs,
  config,
  lib,
  ...
}: let
  cfg = config.local.gui;
in {
  config = lib.mkIf cfg.enable {
    programs.bash = {
      enable = true;
      shellAliases = {
        la = "ls -A";
        susops = "sudo SOPS_AGE_KEY=\"$(sudo cat /run/secrets.d/age-keys.txt)\" sops nixos/hosts/wiggin/hosting/secrets.yaml";
      };
    };

    programs.readline = {
      enable = true;
      bindings = let
        silent = command: ''" \e-\xxkill-line_ \xxbackward-char_\xxkill-line_${command}\xxaccept-line_\xxyank_\xxbeginning-of-line_\xxdelete-char_\xxyank_\xxyank-pop_\xxbackward-delete-char_"'';
      in
        {
          # Readline commands to compose
          "\\xxbeginning-of-line_" = "beginning-of-line"; # Commas improve legibility but are also now necessary
          "\\xxbackward-char_" = "backward-char";
          "\\xxdelete-char_" = "delete-char";
          "\\xxbackward-delete-char_" = "backward-delete-char";
          "\\xxkill-line_" = "kill-line";
          "\\xxaccept-line_" = "accept-line";
          "\\xxyank_" = "yank";
          "\\xxyank-pop_" = "yank-pop";
        }
        // {
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
  };
}
