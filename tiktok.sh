#!/bin/bash
mkdir -p /home/mohammeds/Videos/TikTok/TikTokVideo/"$(date +%Y-%m-%d)"T"$(date +%R:%S)"-Video && cd $_
mkdir -p blur
youtube-dl $(curl -s -H "User-agent: 'your bot 0.1'" https://www.reddit.com/r/TikTokCringe/hot.json?limit=25 | jq '.' | grep url_overridden_by_dest | grep -Eoh "https:\/\/v\.redd\.it\/\w{13}")
for f in *.mp4;
do
  ffmpeg -i $f -lavfi '[0:v]scale=ih*16/9:-1,boxblur=luma_radius=min(h\,w)/20:luma_power=1:chroma_radius=min(cw\,ch)/20:chroma_power=1[bg];[bg][0:v]overlay=(W-w)/2:(H-h)/2,crop=h=iw*9/16' -vb 800K blur/$f ;
done
#rm *.mp4
for f in blur/*.mp4; do echo "file $f" >> file_list.txt ; done
ffmpeg -f concat -safe 0 -i file_list.txt final.mp4
#rm -rf blur

python2 /home/mohammeds/Videos/TikTok/upload.py --file="final.mp4" --title="Funny TikTok Compilation" --description="Buy my merchandise - asir.dev" --keywords="tiktok,cringe" --category="22" --privacyStatus="public"
