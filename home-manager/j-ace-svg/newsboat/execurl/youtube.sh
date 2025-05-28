#!/bin/sh

# Make script fail if any individual commands fail
set -e

# Args: channel_id
channel_id="$1"

# Get channel attributes
channel_url="https://www.youtube.com/channel/$id"
channel_name="$(yt-dlp --print channel "$channel_url")"
mapfile -t video_ids < <(yt-dlp --print id)

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
    for video_id in "${video_ids[@]}"; do
        # Get video attributes
        video_url="https://www.youtube.com/watch?v=$video_id"
        video_title="$(yt-dlp --print title "$video_url")"
        video_date="$(yt-dlp --get-filename -o "%(release_date>%Y-%m-%d)" "$video_url")"
        video_description="$(yt-dlp --print description "$video_url")"
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

    # Ending RSS boilerplate
    echo ""
    echo ""
    echo "</feed>"
}
