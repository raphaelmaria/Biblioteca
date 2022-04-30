#!/bin/sh
sudo docker run -d \
  --name=prowlarr \
  -e PUID=1000 \
  -e PGID=1000 \
  -e TZ=Europe/London \
  -p 9696:9696 \
  -v /path/to/data:/config \
  --restart unless-stopped \
  lscr.io/linuxserver/prowlarr:develop