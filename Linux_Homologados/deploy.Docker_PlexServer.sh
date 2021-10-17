'''
TOKEN:
https://www.plex.tv/claim/
'''
$TOKEN = "claim-h78SaBsgAsdrd9U6_ohp"
$TIMEZONE = "America/Sao_Paulo"
$IPADDRESS = 192.168.15.200
$VARHOST = hostname

docker run \
-d \
--name plex \
-p 32400:32400/tcp \
-p 3005:3005/tcp \
-p 8324:8324/tcp \
-p 32469:32469/tcp \
-p 1900:1900/udp \
-p 32410:32410/udp \
-p 32412:32412/udp \
-p 32413:32413/udp \
-p 32414:32414/udp \
-e TZ=$TIMEZONE \
-e PLEX_CLAIM=$TOKEN \
-e ADVERTISE_IP="http://$IPADDRESS:32400/" \
-h $VARHOST \
-v <path/to/plex/database>:/mnt/dados/multimidia/config \
-v <path/to/transcode/temp>:/transcode \
-v <path/to/media>:/data \
plexinc/pms-docker