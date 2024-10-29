A instalação do Apache com boas práticas no Ubuntu envolve seguir uma série de passos que incluem a instalação, configuração básica de segurança, ajustes de desempenho e a definição de permissões. Aqui está um guia detalhado:

### 1. Instalar o Apache
No Ubuntu, o Apache pode ser instalado facilmente com o gerenciador de pacotes `apt`.

```bash
sudo apt update
sudo apt install apache2 -y
```

### 2. Configurar o Firewall
Certifique-se de que o firewall permita o tráfego para o Apache. No Ubuntu, você pode usar o `ufw` para configurar o firewall.

```bash
sudo ufw allow 'Apache Full'
sudo ufw enable
```

### 3. Configurações Básicas de Segurança
Essas configurações ajudam a proteger o servidor e minimizar riscos.

#### Ocultar a versão do Apache
Por padrão, o Apache exibe informações sobre a versão que está em execução, o que pode ajudar atacantes a identificar possíveis vulnerabilidades.

Edite o arquivo `/etc/apache2/conf-available/security.conf`:

```bash
sudo nano /etc/apache2/conf-available/security.conf
```

Modifique as linhas para ocultar a versão:

```apache
ServerTokens Prod
ServerSignature Off
```

Isso garante que o Apache não exiba informações de versão em mensagens de erro.

#### Ativar HTTPS
Usar HTTPS é uma prática recomendada para criptografar a comunicação entre o servidor e os clientes. Você pode instalar o módulo `mod_ssl` e gerar um certificado SSL.

```bash
sudo apt install openssl
sudo a2enmod ssl
sudo systemctl restart apache2
```

Para adicionar um certificado gratuito, como o Let’s Encrypt, você pode instalar o `certbot`:

```bash
sudo apt install certbot python3-certbot-apache
sudo certbot --apache
```

### 4. Configurar Permissões de Arquivo e Diretório
Defina permissões adequadas para que somente o usuário do Apache tenha acesso de gravação aos diretórios críticos.

- Atribua o diretório web ao usuário e grupo `www-data`:

   ```bash
   sudo chown -R www-data:www-data /var/www/html
   ```

- Ajuste as permissões para garantir segurança:

   ```bash
   sudo find /var/www/html -type d -exec chmod 755 {} \;
   sudo find /var/www/html -type f -exec chmod 644 {} \;
   ```

### 5. Habilitar Módulos e Configurar Virtual Hosts
Para melhor organização e desempenho, habilite módulos essenciais e configure hosts virtuais.

#### Habilitar módulos recomendados
Ative módulos comumente usados, como `rewrite` e `headers`, que são úteis para redirecionamento e controle de cache.

```bash
sudo a2enmod rewrite
sudo a2enmod headers
sudo systemctl restart apache2
```

#### Configurar Virtual Hosts
Para organizar e isolar sites em um único servidor, configure Virtual Hosts. Cada site deve ter seu próprio arquivo de configuração em `/etc/apache2/sites-available/`.

Exemplo de um Virtual Host para um site `exemplo.com`:

```bash
sudo nano /etc/apache2/sites-available/exemplo.com.conf
```

Adicione o seguinte conteúdo, ajustando conforme necessário:

```apache
<VirtualHost *:80>
    ServerName exemplo.com
    ServerAlias www.exemplo.com
    DocumentRoot /var/www/exemplo.com

    <Directory /var/www/exemplo.com>
        AllowOverride All
    </Directory>

    ErrorLog ${APACHE_LOG_DIR}/exemplo.com_error.log
    CustomLog ${APACHE_LOG_DIR}/exemplo.com_access.log combined
</VirtualHost>
```

Ative o Virtual Host:

```bash
sudo a2ensite exemplo.com.conf
sudo systemctl reload apache2
```

### 6. Configurações de Desempenho
Para melhorar o desempenho, configure o cache e ajuste a quantidade de processos que o Apache pode utilizar.

#### Configurar Cache
Use o módulo `mod_cache` para melhorar a velocidade de resposta.

```bash
sudo a2enmod cache
sudo a2enmod cache_disk
sudo a2enmod expires
sudo systemctl restart apache2
```

#### Ajustar Parâmetros de Processo
No arquivo `/etc/apache2/apache2.conf`, configure os parâmetros `MaxRequestWorkers` e `StartServers` de acordo com os recursos do servidor. Por exemplo:

```apache
<IfModule mpm_prefork_module>
    StartServers             5
    MinSpareServers          5
    MaxSpareServers         10
    MaxRequestWorkers       150
    MaxConnectionsPerChild   3000
</IfModule>
```

Esses valores variam de acordo com o uso do servidor e a capacidade de memória. 

### 7. Reiniciar o Apache
Após todas as configurações, reinicie o Apache para aplicar as alterações.

```bash
sudo systemctl restart apache2
```

Com esses passos, seu Apache estará instalado e configurado com boas práticas para desempenho e segurança, estando pronto para produção com configurações de firewall, HTTPS e gerenciamento adequado de permissões e processos.