import requests
import subprocess
import re

def obter_ultima_release(repo_url):
    api_url = f'{repo_url}/releases/latest'
    response = requests.get(api_url)
    if response.status_code == 200:
        return response.json()['tag_name']
    else:
        return None

def fazer_download_e_instalacao(repo_url):
    ultima_release = obter_ultima_release(repo_url)
    if ultima_release:
        deb_url = f'{repo_url}/download/{ultima_release}/emby-server-deb_{ultima_release}_amd64.deb'
        subprocess.run(['wget', deb_url])
        subprocess.run(['sudo', 'dpkg', '-i', f'emby-server-deb_{ultima_release}_amd64.deb'])
        print('Instalação concluída.')
    else:
        print('Não foi possível obter a última release.')

# Exemplo de uso:
repo_url = 'https://github.com/MediaBrowser/Emby.Releases'
fazer_download_e_instalacao(repo_url)
