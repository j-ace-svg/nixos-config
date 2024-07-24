#!/bin/sh

# Make script fail if any individual commands fail
set -e

echo "NixOS Updating..."

# Store previous generation metadata
previous=$(nixos-rebuild list-generations | grep current)

# Rebuild, output simplified errors, log trackebacks
sudo sh -c 'nix flake update /etc/nixos/flake.lock &> /etc/nixos/nixos-update.log' || (cat /etc/nixos/nixos-update.log | grep --color error && exit 1)
sudo sh -c 'nixos-rebuild --flake /etc/nixos#nixos switch &> /etc/nixos/nixos-switch.log' || (cat /etc/nixos/nixos-switch.log | grep --color error && exit 1)

# Get current generation metadata
current=$(nixos-rebuild list-generations | grep current)

# Early return if no changes were detected
if [[ "$previous" == "$current" ]]; then
    echo "No changes detected, exiting."
    exit 0
fi

# Shows your changes
sudo git -C /etc/nixos/ diff -U0 '/etc/nixos' ':!*.log'

# Commit all changes witih the generation metadata
sudo git -C /etc/nixos/ commit -am "$current"

# Notify all OK!
notify-send -e "NixOS Updated OK!" --icon=software-update-available
