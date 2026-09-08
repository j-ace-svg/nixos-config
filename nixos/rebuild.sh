#!/bin/sh

startsudo() { # Background process to prevent re-authenticating sudo
    sudo -v
    ( while true; do sudo -v >/dev/null 2>&1; sleep 50; done; ) &
    SUDO_PID="$!"
    trap stopsudo SIGINT SIGTERM
}
stopsudo() {
    kill "$SUDO_PID"
    trap - SIGINT SIGTERM
    sudo -k
}
prefix="/etc/nixos/"
nixgit() {
    sudo git -C "$prefix" "$@"
}

( # Try rebuilding
    # Make script fail if any individual commands fail
    set -e

    startsudo
    args=""
    # Possible args:
    # -f: Rebuild even if no .nix files are changed
    # -o: Rebuild offline

    for arg in "$@"; do
        if [ "${arg:0:1}" = "-" ]; then
            args+="${arg:0}"
        fi
    done

    if [[ "$args" != *"f"* ]]; then
        # Early return if no changes were detected
        if nixgit diff --quiet; then
            echo "No changes detected, exiting."
            exit 0
        fi
    fi

    # Autoformat your nix files
    sudo alejandra "$prefix" &>/dev/null \
        || ( sudo alejandra "$prefix" ; echo "formatting failed!" && exit 1)

    # Save changes so we only commit what was build (and not any working tree modifications made during build)
    git_pre="$(nixgit stash create)"
    git_pre="${git_pre:-$(nixgit rev-parse --verify HEAD)}"
    # Shows your changes
    nixgit diff -U0 "$prefix/*.nix" || : # Ignore exit code of git diff

    echo "NixOS Rebuilding..."

    rebuild_action="switch"
    if [[ "$args" == *"b"* ]]; then
        rebuild_action="boot"
    fi
    if [[ "$args" == *"r"* ]]; then # Also reboots afterwards
        rebuild_action="boot"
    fi

    rebuild_extra_args=""
    if [[ "$args" == *"o"* ]]; then
        rebuild_extra_args+=" --offline "
    fi
    if [[ "$args" == *"v"* ]]; then
        rebuild_extra_args+=" --show-trace "
    fi
    if [[ "$args" == *"V"* ]]; then
        rebuild_extra_args+=" --print-build-logs "
    fi

    # Rebuild, output simplified errors, log trackebacks
    sudo sh -c "nixos-rebuild ${rebuild_extra_args} --flake '$prefix' $rebuild_action &> '$prefix/nixos-switch.log'" || (cat "$prefix/nixos-switch.log" | grep --color error && exit 1)

    # Get current generation metadata
    current=$(nixos-rebuild list-generations --json | jq -r '.[] | select(.current == true) | (.generation | tostring) + " current" + "  " + .date + "  " + .nixosVersion + "  " + .kernelVersion')
    hostname=$(hostname)

    # Save state after rebuild (to preserve logs/any manual changes made during rebuild)
    git_post="$(nixgit stash create)"
    git_post="${git_post:-$(nixgit rev-parse --verify HEAD)}"
    # Commit all changes witih the generation metadata
    # git stash apply "${git_post}"
    nixgit reset --hard HEAD
    nixgit stash apply "${git_pre}" >/dev/null || nixgit checkout "${git_pre}" -- . >/dev/null
    nixgit commit -am "$hostname: $current"
    nixgit stash apply "${git_post}" &>/dev/null || nixgit checkout "${git_post}" -- . &>/dev/null

    sudo chown -R j-ace-svg:users "$prefix/home-manager/j-ace-svg/"

    if [[ "$args" == *"r"* ]]; then
        notify-send -e "NixOS Rebuild OK! Rebooting..." --icon=software-update-available 2>/dev/null || echo "NixOS Rebuild OK! Rebooting..."
        reboot
    fi

    # Notify all OK!
    notify-send -e "NixOS Rebuilt OK!" --icon=software-update-available 2>/dev/null || echo "NixOS Rebuild OK!"

    stopsudo
)
if [ $? -ne 0 ]; then # Warn if any errors occured
    notify-send -e "Error Rebuilding NixOS" --icon=alert 2>/dev/null || echo "Error Rebuilding NixOS"
fi
