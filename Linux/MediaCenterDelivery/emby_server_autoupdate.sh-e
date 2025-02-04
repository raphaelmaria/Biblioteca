#!/bin/bash

repo_url="https://github.com/MediaBrowser/Emby.Releases"
latest_release=$(curl -sL "$repo_url/releases/latest" | grep -oP '"tag_name": "\K.*?(?=")')
package_url="$repo_url/download/$latest_release/emby-server-deb_${latest_release}_amd64.deb"

https://github.com/MediaBrowser/Emby.Releases/releases/download/4.7.13.0/emby-server-deb_4.7.13.0_amd64.deb

if [ -n "$latest_release" ]; then
    wget "$package_url"
    sudo dpkg -i "emby-server-deb_${latest_release}_amd64.deb"
    echo "Instalação concluída."
else
    echo "Não foi possível obter a última release."
fi
