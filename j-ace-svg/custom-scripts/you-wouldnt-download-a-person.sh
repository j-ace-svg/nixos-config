#!/bin/sh

# Make script fail if any individual commands fail
set -e

while [[ $# != 0 ]]; do
    yt-dlp -xo "%(channel)s/%(playlist_title)s/%(playlist_index)s %(title)s.%(ext)s" "$1"; wait
    shift
done
