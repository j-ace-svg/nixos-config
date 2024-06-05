#!/bin/sh

# Make script fail if any individual commands fail
set -e

echo "NixOS Updating..."

# Rebuild, output simplified errors, log trackebacks
sudo sh -c 'nix flake update &> /etc/nixos/nixos-update.log' || (cat /etc/nixos/nixos-update.log | grep --color error && exit 1)
sudo sh -c 'nixos-rebuild --flake /etc/nixos#nixos switch &> /etc/nixos/nixos-switch.log' || (cat /etc/nixos/nixos-switch.log | grep --color error && exit 1)

# Shows your changes
sudo git diff -U0

# Get current generation metadata
current=$(nixos-rebuild list-generations | grep current)

# Commit all changes witih the generation metadata
sudo git commit -am "$current"

# Notify all OK!
notify-send -e "NixOS Updated OK!" --icon=software-update-available
