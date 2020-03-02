#!/bin/bash
#
#
# Script para instalação adequação do codec FFMPEG para o codec Libav
# Criado por Raphael Maria | raphaelmaria.com.br
# 
#
umount /opt
cd /tmp
yum install libvorbis  yasm freetype zlib bzip2 faac lame speex libvpx libogg  libtheora  x264 XviD openjpeg15 opencore-amr
wget http://libav.org/releases/libav-10.1.tar.gz
tar -xvzf libav-10.1.tar.gz
cd libav-10.1
./configure
make
make install
whereis avconv


