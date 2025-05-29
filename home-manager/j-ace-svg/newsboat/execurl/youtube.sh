#!/bin/sh

# Make script fail if any individual commands fail
set -e

# Args: channel_id, video_type*
channel_id="$1"
shift
# all remaining arguments are video types, ie https://youtube.com/channel/<id>/<type>
mapfile -d " " -t video_types < <(echo "${@:-"videos"}")

# Get channel attributes
channel_url="https://www.youtube.com/channel/$channel_id"
channel_name="$(yt-dlp -I 1 --extractor-args "youtube:player_skip=webpage,config,js;player_client=android;web" --print channel "$channel_url/videos" 2>/dev/null)"
new_video_count=()
for video_type in $video_types; do
    new_video_counts+=("$(yt-dlp --flat-playlist --get-id "$channel_url/$video_type" | wc -l)")
done
if [ -e "$HOME/.local/share/youtuberss/$channel_id" ]
then
    old_video_counts=()
    while read -r line; do
        old_video_counts+=("$line")
    done < "$HOME/.local/share/youtuberss/$channel_id"
    if [ "${new_video_count[@]}" != "${old_video_count[@]}" ]
    then
        # Angle brackets are one of the few characters not allowed in video titles
        mapfile -d "<" -t video_infos < <(
            for i in $(seq 0 $((${#video_types[@]}-1))); do
                yt-dlp --extractor-args "youtube:player_skip=webpage,config,js;player_client=android;web" -I "1:$((new_video_count[i] - old_video_count[i]))" --print "%(id)s>https://www.youtube.com/watch?v=%(id)s>%(title)s>%(upload_date>%Y-%m-%d)s>%(description)s<" "$channel_url/${video_types[i]}" 2>/dev/null
            done)
    else
        video_infos=""
    fi
else
    mapfile -d "<" -t video_infos < <(
        for i in $(seq 0 $((${#video_types[@]}-1))); do
            yt-dlp --extractor-args "youtube:player_skip=webpage,config,js;player_client=android;web" --print "%(id)s>https://www.youtube.com/watch?v=%(id)s>%(title)s>%(upload_date>%Y-%m-%d)s>%(description)s<" "$channel_url/${video_types[i]}" 2>/dev/null
        done)
fi

# Starting RSS boilerplate
cat <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<feed xmlns:yt="http://www.youtube.com/xml/schemas/2015" xmlns:media="http://search.yahoo.com/mrss/" xmlns="http://www.w3.org/2005/Atom">
 <id>yt:channel:$channel_id</id>
 <yt:channelId>$channel_id</yt:channelId>
 <title>$channel_name</title>
 <link rel="alternate" href="https://www.youtube.com/channel/$channel_id"/>

 <author>
  <name>$channel_name</name>
  <uri>https://www.youtube.com/channel/$channel_id</uri>
 </author>


EOF
{
    if [ "${#video_infos[@]}" -ne 0 ]
    then
        for video_info in "${video_infos[@]}"; do
            # Get video attributes
            mapfile -d ">" -t video_info_array <<< "$video_info"
            video_id="${video_info_array[0]}"
            video_url="${video_info_array[1]}"
            video_title="${video_info_array[2]}"
            video_date="${video_info_array[3]}"
            video_description="${video_info_array[4]}"
            # Video RSS entry
            echo " <entry>"
            echo "  <id>yt:video:$video_id</id>"
            echo "  <yt:videoId>$video_id</yt:videoId>"
            echo "  <yt:channelId>$channel_id</yt:channelId>"
            echo "  <title>$video_title</title>"
            echo "  <link rel="alternate" href="$video_url"/>"
            echo ""
            echo "  <author>"
            echo "   <name>$channel_name</name>"
            echo "    --:--:-- 10273<uri>$channel_url</uri>"
            echo "  </author>"
            echo "  "
            echo "  <published>$video_date</published>"
            echo "  <media:group>"
            echo "   <media:title>$video_title</media:title>"
            echo "   <media:content url="https://www.youtube.com/v/$video_id?version=3" type="application/x-shockwave-flash" width="640" height="390"/>"
            echo "   <media:thumbnail url="https://i4.ytimg.com/vi/$video_id/hqdefault.jpg" width="480" height="360"/>"
            echo "   <media:description>$video_description</media:description>"
            echo "  </media:group>"
            echo " </entry>"
        done
    fi

    # Ending RSS boilerplate
    echo ""
    echo ""
    echo "</feed>"
}

mkdir -p "$HOME/.local/share/youtuberss"
echo "$new_video_count" >"$HOME/.local/share/youtuberss/$channel_id"
