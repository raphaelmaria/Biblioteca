Para transformar uma imagem ISO do Ubuntu em uma imagem OEM personalizada, você pode seguir os seguintes passos:

Faça o download da imagem ISO do Ubuntu que deseja personalizar.

Crie uma pasta para trabalhar com os arquivos da imagem ISO:


mkdir ubuntu-oem

Monte a imagem ISO na pasta que você acabou de criar:

sudo mount -o loop ubuntu.iso ubuntu-oem/

Extraia os arquivos da imagem ISO para uma nova pasta:

rsync -a ubuntu-oem/ ubuntu-oem-copy/

Edite o arquivo "/etc/casper.conf" com o editor de texto de sua preferência. Este arquivo contém as configurações do ambiente live do Ubuntu. Você pode definir, por exemplo, o idioma padrão, o fuso horário, a configuração da rede, etc.

Remova o arquivo "/etc/udev/rules.d/70-persistent-net.rules", que contém a configuração da interface de rede. Isso fará com que a interface de rede seja configurada automaticamente durante a inicialização.

Personalize a imagem OEM de acordo com as suas necessidades, adicionando ou removendo programas, personalizando o tema e o papel de parede, etc.

Crie uma nova imagem ISO a partir da pasta com os arquivos modificados:

mkisofs -r -V "Ubuntu OEM" -cache-inodes -J -l -b isolinux/isolinux.bin -c isolinux/boot.cat -no-emul-boot -boot-load-size 4 -boot-info-table -o ubuntu-oem-modified.iso ubuntu-oem-copy/

Teste a nova imagem ISO em um ambiente virtual ou grave em uma mídia física para testar em um hardware real.

Após seguir esses passos, você terá criado uma imagem OEM personalizada do Ubuntu. Essa imagem poderá ser instalada em diversos computadores sem a necessidade de configurar cada um deles individualmente.