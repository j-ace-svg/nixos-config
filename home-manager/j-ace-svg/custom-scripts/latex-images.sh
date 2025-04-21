#!/bin/sh

# Make script fail if any individual commands fail
set -e

if [[ $# = 0 ]] || [[ "$1" = "-h" ]]; then
    if [[ $# = 0 ]]; then
        echo "Pull images from pdf at a given url"
        echo ""
    fi

    # Help menu
    echo "Usage: latex-images [OPTIONS] NAME"
    echo ""
    echo "Options:"
    printf '%s/n' \
        "-h/Display this help text" \
        | column -t -s "/"
    exit 0
fi

url="$1"

curl "$url" -o /tmp/remote.pdf
mkdir images
pdfimages -all /tmp/remote.pdf images/ext
rm /tmp/remote.pdf
