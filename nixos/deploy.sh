#!/bin/sh

startsudo() { # Background process to prevent re-authenticating sudo
    sudo -v
    ( while true; do sudo -v; sleep 50; done; ) &
    SUDO_PID="$!"
    trap stopsudo SIGINT SIGTERM
}
stopsudo() {
    kill "$SUDO_PID"
    trap - SIGINT SIGTERM
    sudo -k
}

( # Try rebuilding
    # Make script fail if any individual commands fail
    set -e

    startsudo
    args=""
    # Possible args:
    # -f: Rebuild even if no .nix files are changed
    # -o: Rebuild offline
    hosts=()

    for arg in "$@"; do
        if [ "${arg:0:1}" = "-" ]; then
            args+="${arg:0}"
        else
            hosts+=(arg)
        fi
    done
    git_paths=('/etc/nixos/flake.nix' $(printf "/etc/nixos/nixos/hosts/%q/" ${hosts[@]}) '/etc/nixos/nixos/modules/hosting/')

    if [[ "$args" != *"f"* ]]; then
        # Early return if no changes were detected
        if sudo git -C /etc/nixos/ diff --quiet ${git_paths[@]}; then
            echo "No changes detected, exiting."
            exit 0
        fi
    fi

    # Autoformat your nix files
    sudo alejandra /etc/nixos &>/dev/null \
        || ( sudo alejandra /etc/nixos ; echo "formatting failed!" && exit 1)

    # Shows your changes
    sudo git -C /etc/nixos/ diff -U0 ${git_paths[@]} || : # Ignore exit code of git diff

    echo "NixOS Deploying..."

    rebuild_extra_args=""
    if [[ "$args" == *"o"* ]]; then
        rebuild_extra_args+=" --offline "
    fi
    if [[ "$args" == *"v"* ]]; then
        rebuild_extra_args+=" --show-trace "
    fi

    # Deploy, output simplified errors, log trackebacks
    for host in ${hosts[@]}; do
        sudo sh -c "nixos-rebuild ${rebuild_extra_args} --flake /etc/nixos#${host} --build-host ${host} --target-host ${host} switch &> /etc/nixos/nixos-switch.log" || (cat /etc/nixos/nixos-switch.log | grep --color error && exit 1)
    done

    # Get current generation metadata
    current=$(nixos-rebuild list-generations | grep current)
    hostname=$(printf "%q," ${hosts[@]})

    # Commit all changes witih the generation metadata
    git_stash_pathspec=$(printf ":(exclude)%q" ${git_paths[@]})
    sudo git stash push ${git_stash_pathspec[@]} -m "Deployment non-server changes"
    sudo git -C /etc/nixos/ commit -am "$hostname: $current"
    sudo git stash pop

    # Notify all OK!
    notify-send -e "NixOS Deployed OK!" --icon=software-update-available

    stopsudo
)
if [ $? -ne 0 ]; then # Warn if any errors occured
    notify-send -e "Error Deploying NixOS" --icon=alert
fi
