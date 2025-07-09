#!/bin/sh

( # Try rebuilding
    # Make script fail if any individual commands fail
    set -e

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
        if sudo git -C /etc/nixos/ diff --quiet '/etc/nixos/*.nix'; then
            echo "No changes detected, exiting."
            exit 0
        fi
    fi

    # Autoformat your nix files
    sudo alejandra /etc/nixos &>/dev/null \
        || ( sudo alejandra /etc/nixos ; echo "formatting failed!" && exit 1)

    # Shows your changes
    sudo git -C /etc/nixos/ diff -U0 '/etc/nixos/*.nix' || : # Ignore exit code of git diff

    echo "NixOS Rebuilding..."

    rebuild_extra_args=""
    if [[ "$args" == *"o"* ]]; then
        rebuild_extra_args+=" --offline "
    fi
    if [[ "$args" == *"v"* ]]; then
        rebuild_extra_args+=" --show-trace "
    fi

    # Rebuild, output simplified errors, log trackebacks
    sudo sh -c "nixos-rebuild ${rebuild_extra_args} --flake /etc/nixos switch &> /etc/nixos/nixos-switch.log" || (cat /etc/nixos/nixos-switch.log | grep --color error && exit 1)

    # Get current generation metadata
    current=$(nixos-rebuild list-generations | grep current)
    hostname=$(hostname)

    # Commit all changes witih the generation metadata
    sudo git -C /etc/nixos/ commit -am "$hostname: $current"

    # Notify all OK!
    notify-send -e "NixOS Rebuilt OK!" --icon=software-update-available

)
if [ $? -ne 0 ]; then # Warn if any errors occured
    notify-send -e "Error Rebuilding NixOS" --icon=alert
fi
