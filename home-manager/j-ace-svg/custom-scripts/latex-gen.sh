#!/bin/sh

# Make script fail if any individual commands fail
set -e

if [[ $# = 0 ]] || [[ "$1" = "-h" ]]; then
    if [[ $# = 0 ]]; then
        echo "Generate Latex Config"
        echo ""
    fi

    # Help menu
    echo "Usage: latex-gen [OPTIONS] NAME"
    echo ""
    echo "Options:"
    printf '%s/n' \
        "-h/Display this help text" \
        | column -t -s "/"
    exit 0
fi

name="$1"

mkdir -p "$name"
pushd "$name" >/dev/null
ln -s ~/.config/latex/preamble.sty .
cp ~/.config/latex/main.tex .
chmod u+w main.tex
mkdir images
popd >/dev/null
