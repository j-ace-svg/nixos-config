{
  pkgs,
  config,
  lib,
  ...
}: {
  programs.tmux = {
    enable = true;
    prefix = "C-_";
    clock24 = true;
    extraConfig =
      lib.concatLines (map (s: "unbind ${s}") ([
          "Space"
          "!"
          "\\\""
          "\\#"
          "\\$"
          "\\%"
          "&"
          "\\'"
          "("
          ")"
          ","
          "-"
          "."
          "/"
          ":"
          "\\;"
          "="
          "?"
          "C"
          "D"
          "E"
          "L"
          "M"
          "["
          "]"
          "c"
          "d"
          "f"
          "i"
          "l"
          "m"
          "n"
          "o"
          "p"
          "q"
          "r"
          "s"
          "t"
          "w"
          "x"
          "z"
          "\\{"
          "\\}"
          "\\~"
          "DC"
          "PPage"
          "Up"
          "Down"
          "Left"
          "Right"
          "M-n"
          "M-o"
          "M-p"
          "M-Up"
          "M-Down"
          "M-Left"
          "M-Right"
          "C-o"
          "C-z"
          "C-Up"
          "C-Down"
          "C-Left"
          "C-Right"
          "S-Up"
          "S-Down"
          "S-Left"
          "S-Right"
        ]
        ++ (builtins.genList builtins.toString 10)
        ++ (builtins.genList (n: "M-${builtins.toString (n + 1)}") 7)))
      + ''
        bind -N "Arrange the current window in the next  preset layout." \
          Space next-layout
        bind -N "Break the current pane out of the window." \
          ! break-pane
        bind -N "Split the current pane into two, top and bottom." \
          \" split-window
        bind -N "List all paste buffers." \
          \# list-buffers
        bind -N "Rename the current session." \
          \$ command-prompt -I "#S" { rename-session "%%" }
        bind -N "Split the current pane into two, left and right." \
          \% split-window -h
        bind -N "Kill the current window." \
          & confirm-before -p "kill window #W (y/n)" kill-window
        bind -N "Prompt for a window index to select." \
          \' command-prompt -T window-target -p index { select-window -t ":%%" }
        bind -N "Switch the attached client to the previous session." \
          ( switch-client -p
        bind -N "Switch the attached client to the next session." \
          ) switch-client -n
        bind -N "Rename the current window." \
          , command-prompt -I "#W" { rename-window "%%" }
        bind -N "Delete the most recently copied buffer of text." \
          - delete-buffer
        bind -N "Prompt for an index to move the current window." \
          . command-prompt -T target { move-window -t "%%" }
        bind -N "Describe key binding" \
          / command-prompt -k -p key { list-keys -1N "%%" }
        bind -N "Select window 0" \
          0 select-window -t :=0
        bind -N "Select window 1" \
          1 select-window -t :=1
        bind -N "Select window 2" \
          2 select-window -t :=2
        bind -N "Select window 3" \
          3 select-window -t :=3
        bind -N "Select window 4" \
          4 select-window -t :=4
        bind -N "Select window 5" \
          5 select-window -t :=5
        bind -N "Select window 6" \
          6 select-window -t :=6
        bind -N "Select window 7" \
          7 select-window -t :=7
        bind -N "Select window 8" \
          8 select-window -t :=8
        bind -N "Select window 9" \
          9 select-window -t :=9
        bind -N "Enter the tmux command prompt." \
          : command-prompt
        bind -N "Move to the previously active pane." \
          \; last-pane
        bind -N "Choose  which  buffer  to paste interactively from a list." \
          = choose-buffer -Z
        bind -N "List all key bindings." \
          ? list-keys -N
        bind -N "Customize options" \
          C customize-mode -Z
        bind -N "Choose a client to detach." \
          D choose-client -Z
        bind -N "Spread panes out evenly" \
          E select-layout -E
        bind -N "Switch the attached client back to the last session." \
          L switch-client -l
        bind -N "Clear the marked pane." \
          M select-pane -M
        bind -N "Enter copy mode to copy text or view the history." \
          [ copy-mode
        bind -N "Paste the most recently copied buffer of text." \
          ] paste-buffer -p
        bind -N "Create a new window." \
          c new-window
        bind -N "Detach the current client." \
          d detach-client
        bind -N "Prompt to search for text in open windows." \
          f command-prompt { find-window -Z "%%" }
        bind -N "Display some information about the current window." \
          i display-message
        bind -N "Move to the previously selected window." \
          l last-window
        bind -N "Mark the current pane (see select-pane -m)." \
          m select-pane -m
        bind -N "Change to the next window." \
          n next-window
        bind -N "Select the next pane in the current window." \
          o select-pane -t :.+
        bind -N "Change to the previous window." \
          p previous-window
        bind -N "Briefly display pane indexes." \
          q display-panes
        bind -N "Force redraw of the attached client." \
          r refresh-client
        bind -N "Select a new session for the attached client interactively." \
          s choose-tree -Zs
        bind -N "Show the time." \
          t clock-mode
        bind -N "Choose the current window interactively." \
          w choose-tree -Zw
        bind -N "Kill the current pane." \
          x confirm-before -p "kill-pane #P? (y/n)" kill-pane
        bind -N "Toggle zoom state of the current pane." \
          z resize-pane -Z
        bind -N "Swap the current pane with the previous pane." \
          \{
        bind -N "Swap the current pane with the next pane." \
          \}
        bind -N "Show previous messages from tmux, if any." \
          \~ show-messages
        bind -r -N "Reset so the visible part of the window follows the cursor" \
          DC refresh-client -C
        bind -N "Enter copy mode and scroll one page up." \
          PPage copy-mode -u
        bind -r -N "Select the pane above the active pane" \
          Up select-pane -U
        bind -r -N "Select the pane below the active pane" \
          Down select-pane -D
        bind -r -N "Select the pane to the left of the active pane" \
          Left select-pane -L
        bind -r -N "Select the pane to the right of the active pane" \
          Right select-pane -R
        bind -N "Set the even-horizontal layout" \
          M-1 select-layout even-horizontal
        bind -N "Set the even-vertical layout" \
          M-2 select-layout even-vertical
        bind -N "Set the main-horizontal layout" \
          M-3 select-layout main-horizontal
        bind -N "Set the main-vertical layout" \
          M-4 select-layout main-vertical
        bind -N "Set the tiled layout" \
          M-5 select-layout tiled
        bind -N "Set the main-horizontal-mirrored layout" \
          M-6 select-layout main-horizontal-mirrored
        bind -N "Set the main-vertical-mirrored layout" \
          M-7 select-layout main-vertical-mirrored
        bind -N "Move  to  the  next  window  with a bell or activity marker." \
          M-n next-window -a
        bind -N "Rotate the panes in the current window backwards." \
          M-o rotate-window -D
        bind -N "Move to the previous window with a bell or activity marker." \
          M-p previous-window -a
        bind -r -N "Resize the pane up by 5" \
          M-Up resize-pane U 5
        bind -r -N "Resize the pane down by 5" \
          M-Down resize-pane D 5
        bind -r -N "Resize the pane left by 5" \
          M-Left resize-pane L 5
        bind -r -N "Resize the pane right by 5" \
          M-Right resize-pane R 5
        bind -N "Rotate the panes in the current window forwards." \
          C-o rotate-window
        bind -N "Suspend the tmux client." \
          C-z suspend
        bind -r -N "Resize the pane up" \
          C-Up resize-pane -U
        bind -r -N "Resize the pane down" \
          C-Down resize-pane -D
        bind -r -N "Resize the pane left" \
          C-Left resize-pane -L
        bind -r -N "Resize the pane right" \
          C-Right resize-pane -R
        bind -r -N "Move the visible part of the window up" \
          S-Up refresh-client -U 10
        bind -r -N "Move the visible part of the window down" \
          S-Down refresh-client -D 10
        bind -r -N "Move the visible part of the window left" \
          S-Left refresh-client -L 10
        bind -r -N "Move the visible part of the window right" \
          S-Right refresh-client -R 10
        bind C-a split-window
      '';
  };

  home.packages = [
  ];
}
