#!/bin/sh
sudo docker run -d \
  --name=radarr \
  -e PUID=1000 \
  -e PGID=1000 \
  -e TZ=Europe/London \
  -p 7878:7878 \
  -v /path/to/data:/config \
  -v /path/to/movies:/multimidia/downloads/movies `#optional` \
  -v /path/to/downloadclient-downloads:/multimidia/lixeira `#optional` \
  --restart unless-stopped \
  lscr.io/linuxserver/radarr