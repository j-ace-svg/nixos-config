#!/bin/sh

# Make script fail if any individual commands fail
set -e

if [ "$1" != "-f" ]; then
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
sudo git -C /etc/nixos/ diff -U0 '/etc/nixos/*.nix'

echo "NixOS Rebuilding..."

# Rebuild, output simplified errors, log trackebacks
sudo sh -c 'nixos-rebuild --flake /etc/nixos switch &> /etc/nixos/nixos-switch.log' || (cat /etc/nixos/nixos-switch.log | grep --color error && exit 1)

# Get current generation metadata
current=$(nixos-rebuild list-generations | grep current)
hostname=$(hostname)

# Commit all changes witih the generation metadata
sudo git -C /etc/nixos/ commit -am "$hostname: $current"

# Notify all OK!
notify-send -e "NixOS Rebuilt OK!" --icon=software-update-available
