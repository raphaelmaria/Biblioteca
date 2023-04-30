Para alterar o splash boot (tela de inicialização) do Ubuntu, você pode seguir os seguintes passos:

Faça backup dos arquivos existentes: É sempre uma boa ideia fazer backup dos arquivos originais antes de fazer qualquer alteração. Você pode fazer isso copiando a pasta /usr/share/plymouth/themes/ubuntu-logo para um local seguro, por exemplo:


sudo cp -r /usr/share/plymouth/themes/ubuntu-logo ~/backup_ubuntu_splash

Escolha um novo tema de splash boot: Existem muitos temas de splash boot disponíveis na internet. Você pode baixar um tema de sua escolha e salvá-lo em uma pasta, por exemplo:

mkdir ~/new_splash_theme

Extrair o novo tema: Extrair o tema baixado para a pasta criada. Dependendo do formato do tema, você pode precisar usar o comando tar ou unzip para extrair o tema. Por exemplo:


tar -xvf theme.tar.gz -C ~/new_splash_theme

Copie o novo tema para a pasta de temas de Plymouth: Copie a pasta do novo tema para a pasta de temas de Plymouth, por exemplo:


sudo cp -r ~/new_splash_theme /usr/share/plymouth/themes/

Atualize o arquivo de configuração: Agora você precisa atualizar o arquivo de configuração para usar o novo tema. Abra o arquivo /etc/alternatives/default.plymouth com um editor de texto, por exemplo:


sudo nano /etc/alternatives/default.plymouth

Altere o tema: Altere o valor de "ubuntu-logo" para o nome do novo tema que você copiou para a pasta de temas de Plymouth. Por exemplo:


. /usr/share/plymouth/themes/new_splash_theme/new_splash_theme.plymouth

Atualize o initramfs: Por fim, você precisa atualizar o initramfs para que as mudanças entrem em vigor. Use o seguinte comando:


sudo update-initramfs -u

Reinicie o sistema: Reinicie o sistema para ver o novo splash boot em ação.

Lembre-se de que o processo de alteração do splash boot pode variar dependendo da versão do Ubuntu que você está usando e do tema que você deseja usar. Certifique-se de seguir as instruções fornecidas com o tema que você deseja usar e sempre faça backup dos arquivos originais antes de fazer qualquer alteração.