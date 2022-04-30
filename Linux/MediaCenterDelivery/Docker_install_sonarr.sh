#!/bin/sh
sudo docker run -d \
--name=sonarr \
-e PUID=1000 \
-e PGID=1000 \
-e TZ=Europe/London \
-p 8989:8989 \
-v /path/to/data:/config \
-v /path/to/tvseries:/multimidia/downloads/series `#optional` \
-v /path/to/downloadclient-downloads:/multimidia/lixeira `#optional` \
--restart unless-stopped \
lscr.io/linuxserver/sonarr