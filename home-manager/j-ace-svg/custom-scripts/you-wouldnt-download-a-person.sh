#!/bin/sh

# Make script fail if any individual commands fail
set -e

args=""
if [ "${arg:0:1}" = "-" ]; then
    args="${arg:0}"
fi

if [[ "$args" = "" ]] || [[ "$args" == *"h"* ]]; then
    if [[ "$args" = "" ]]; then
      # App introduction
      echo "You wouldn't download a person - quickly download music from a youtube url"
      echo ""
    fi

    # Help menu
    echo "Usage: you-wouldnt-download-a-person [OPTIONS] URL [URL...]"
    echo ""
    echo "Options:"
    printf '%s\n' \
	    "-h/Display this help text" \
	    "-r/Download all songs from a channel's releases page" \
	    "-a/Download a single album from within an artist's folder" \
	    "-s/Download a single song to an artist's folder" \
	    | column -t -s "/"
    exit 0
fi

dlExtraArgs=""

if [[ "$args" == *"s"* ]]; then
    dlExtraArgs+='--parse-metadata "album:(?P<playlist_title>)"'
fi

if [[ "$args" == *"s"* ]]; then
    shift
    yt-dlp "$dlExtraArgs" -xo "%(title)s.%(ext)s" "$1"
fi

if [[ "$args" == *"a"* ]]; then
    shift
    yt-dlp "$dlExtraArgs" -xo "%(playlist_title)s/%(playlist_index)s %(title)s.%(ext)s" "$1"
fi


if [[ "$args" == *"a"* ]]; then
    shift
    yt-dlp "$dlExtraArgs" -xo "%(playlist_title)s/%(playlist_index)s %(title)s.%(ext)s" "$1"
fi

if [[ "$args" == *"r"* ]]; then
    shift
    while [[ $# != 0 ]]; do
        channel="$(yt-dlp --print channel "$1")"
        echo "$channel"
        mkdir "$channel"
        pushd "$channel"
        yt-dlp "$dlExtraArgs" -xo "%(channel)s/%(playlist_title)s/%(playlist_index)s %(title)s.%(ext)s" "$1"
        shift
        popd
    done

    exit 0
fi
