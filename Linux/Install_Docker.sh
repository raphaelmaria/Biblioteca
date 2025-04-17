#!/usr/bin/sh

curl -sSL https://get.docker.com | sh
/etc/init.d/docker start
ps -aux | grep "docker" ou docker ps
docker images
docker -run -i -t ubuntu:14.10 /bin/bash
cat /etc/issue

ps -ef

control+D: mata o container
Control+P+D
docker -ps

docker attach [Container ID]


