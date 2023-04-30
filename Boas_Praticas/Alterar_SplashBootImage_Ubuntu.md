Para alterar a imagem do splash boot do Ubuntu e colocar um logo de sua preferência, você pode seguir os seguintes passos:

Crie uma imagem no formato PNG com o logo que deseja usar como splash boot. O tamanho recomendado para a imagem é de 1920x1080 pixels.

Renomeie a imagem para "splash.png" e copie-a para a pasta "/usr/share/plymouth/themes/ubuntu-logo".


sudo cp caminho/da/imagem/splash.png /usr/share/plymouth/themes/ubuntu-logo/splash.png

Abra o arquivo "/usr/share/plymouth/themes/ubuntu-logo/ubuntu-logo.script" com um editor de texto.


sudo nano /usr/share/plymouth/themes/ubuntu-logo/ubuntu-logo.script

Localize a linha que contém o comando "image-png". Deve ser algo parecido com:


image-png /usr/share/plymouth/themes/ubuntu-logo/ubuntu-logo.png;

Substitua o caminho da imagem "ubuntu-logo.png" pelo caminho da sua nova imagem "splash.png". A linha deve ficar assim:


image-png /usr/share/plymouth/themes/ubuntu-logo/splash.png;

Salve o arquivo e feche o editor de texto.

Atualize o initramfs com o comando:


sudo update-initramfs -u

Isso irá atualizar a imagem do splash boot no initramfs.

Reinicie o sistema para ver a nova imagem do splash boot.

Após seguir esses passos, a imagem do splash boot será alterada para o seu logo personalizado. Note que, ao atualizar o sistema ou a imagem do kernel, pode ser necessário repetir esses passos para que a imagem do splash boot continue sendo exibida corretamente.