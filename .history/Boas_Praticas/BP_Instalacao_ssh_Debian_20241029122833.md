A instalação e configuração do SSH Server com boas práticas em um Linux Debian 11 envolve reforço de segurança e ajustes para tornar o serviço mais seguro e eficiente. Aqui estão as recomendações detalhadas:

### 1. Instalar o OpenSSH Server

1. Atualize a lista de pacotes e instale o OpenSSH Server:

   ```bash
   sudo apt update && sudo apt upgrade -y
   sudo apt install openssh-server -y
   ```

2. Verifique o status do serviço para garantir que ele está rodando:

   ```bash
   sudo systemctl status ssh
   ```

### 2. Configurar Firewall

Para restringir o acesso ao SSH apenas para conexões seguras, configure o `ufw` (Uncomplicated Firewall), permitindo o tráfego somente para a porta SSH.

```bash
sudo apt install ufw -y
sudo ufw allow OpenSSH
sudo ufw enable
```

### 3. Alterar a Porta Padrão do SSH

Usar uma porta diferente da padrão (`22`) pode reduzir tentativas de ataque automatizadas.

1. Edite o arquivo de configuração do SSH:

   ```bash
   sudo nano /etc/ssh/sshd_config
   ```

2. Altere a linha para uma porta não utilizada (por exemplo, `2222`):

   ```bash
   Port 2222
   ```

3. Após salvar, reinicie o serviço SSH:

   ```bash
   sudo systemctl restart ssh
   ```

### 4. Desabilitar o Login de Root

Para impedir que o usuário `root` faça login diretamente via SSH, ajuste a configuração:

1. Ainda no arquivo `/etc/ssh/sshd_config`, encontre e altere:

   ```bash
   PermitRootLogin no
   ```

2. Salve e reinicie o SSH:

   ```bash
   sudo systemctl restart ssh
   ```

### 5. Usar Autenticação por Chave Pública

Configurar a autenticação por chave pública elimina a necessidade de usar senhas, que podem ser mais vulneráveis a ataques.

1. No cliente (seu computador), gere uma chave SSH (caso ainda não tenha uma):

   ```bash
   ssh-keygen -t rsa -b 4096
   ```

2. Copie a chave pública para o servidor Debian:

   ```bash
   ssh-copy-id -p 2222 usuario@seu-servidor
   ```

3. Desabilite a autenticação por senha no servidor, adicionando ou ajustando a linha no arquivo de configuração `/etc/ssh/sshd_config`:

   ```bash
   PasswordAuthentication no
   ```

4. Reinicie o SSH:

   ```bash
   sudo systemctl restart ssh
   ```

### 6. Limitar Usuários e Grupos Autorizados

Restringir o acesso SSH a usuários específicos é uma boa prática para segurança adicional.

1. No `/etc/ssh/sshd_config`, adicione as linhas abaixo para especificar os usuários ou grupos permitidos:

   ```bash
   AllowUsers usuario1 usuario2
   ```

   ou para grupos:

   ```bash
   AllowGroups sshusers
   ```

2. Reinicie o serviço:

   ```bash
   sudo systemctl restart ssh
   ```

### 7. Habilitar o `Fail2Ban` para Proteger contra Tentativas de Login

O `Fail2Ban` bloqueia endereços IP que falham em se autenticar repetidamente.

1. Instale o `fail2ban`:

   ```bash
   sudo apt install fail2ban -y
   ```

2. Crie um arquivo de configuração local para personalizar o comportamento:

   ```bash
   sudo cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.local
   ```

3. No arquivo `/etc/fail2ban/jail.local`, localize a seção `[sshd]` e configure as opções desejadas, como o número de tentativas antes de bloquear e a duração do bloqueio.

4. Inicie e habilite o `fail2ban`:

   ```bash
   sudo systemctl enable --now fail2ban
   ```

5. Verifique o status do `fail2ban` para confirmar:

   ```bash
   sudo fail2ban-client status sshd
   ```

### 8. Outras Configurações de Segurança

#### Configurar o Tempo de Inatividade para Fechar Sessões Inativas

Configure o tempo máximo permitido para uma sessão SSH ociosa.

1. No arquivo `/etc/ssh/sshd_config`, defina:

   ```bash
   ClientAliveInterval 300
   ClientAliveCountMax 2
   ```

Isso fecha sessões inativas após 10 minutos (300 * 2 segundos) sem atividade.

#### Habilitar o SSH Protocol 2

As versões antigas do protocolo SSH podem ser menos seguras. O protocolo 2 é o recomendado.

1. No arquivo de configuração SSH:

   ```bash
   Protocol 2
   ```

2. Reinicie o SSH para aplicar as mudanças:

   ```bash
   sudo systemctl restart ssh
   ```

### 9. Teste as Configurações

Após configurar o SSH com essas práticas de segurança, teste o acesso com as novas configurações:

1. Abra uma nova sessão de terminal e conecte-se ao servidor usando a porta personalizada e autenticação por chave pública.

2. Após confirmar que tudo está funcionando, você pode fechar a conexão.

---

Essas configurações oferecem segurança adicional e reforçam a proteção do servidor contra acessos indesejados, reduzindo a exposição a ataques e melhorando o gerenciamento de permissões e autenticação.