echo "# Configuracao Apache 2.X
# Alexandre Correa
# alexandre at sabbath . com . br
#####################################
#Estas 2 opcoes impedem que o apache mostre sua versao e a versao de seus modulos
#dificultando acoes de usuarios com mas intencoes
ServerTokens Prod
ServerSignature Off

#Diretorio onde esta instalado o apache (configuracoes)
ServerRoot "/etc/httpd"
#Arquivo onde o apache ira guardar o PID
PidFile run/httpd.pid
#Timeout das conexoes
Timeout 300

KeepAlive Off
MaxKeepAliveRequests 100
KeepAliveTimeout 15

<IfModule prefork.c>
StartServers       8
MinSpareServers    5
MaxSpareServers   20
MaxClients       150
MaxRequestsPerChild  1000
</IfModule>
<IfModule worker.c>
StartServers         2
MaxClients         150
MinSpareThreads     25
MaxSpareThreads     75
ThreadsPerChild     25
MaxRequestsPerChild  0
</IfModule>
<IfModule perchild.c>
NumServers           5
StartThreads         5
MinSpareThreads      5
MaxSpareThreads     10
MaxThreadsPerChild  20
MaxRequestsPerChild  0
</IfModule>

#Listen pode ser usado das seguintes maneiras
# Listen IP:PORTA
# Listen *:80 (abre a porta 80 em TODOS os ips que a maquina possuir)
# Listen 127.0.0.1:81 (abre a porta 81 no ip 127.0.0.1)

Listen *:80

LoadModule access_module modules/mod_access.so
LoadModule auth_module modules/mod_auth.so
LoadModule auth_anon_module modules/mod_auth_anon.so
LoadModule auth_dbm_module modules/mod_auth_dbm.so
LoadModule auth_digest_module modules/mod_auth_digest.so
LoadModule include_module modules/mod_include.so
LoadModule log_config_module modules/mod_log_config.so
LoadModule env_module modules/mod_env.so
LoadModule mime_magic_module modules/mod_mime_magic.so
LoadModule cern_meta_module modules/mod_cern_meta.so
LoadModule expires_module modules/mod_expires.so
LoadModule headers_module modules/mod_headers.so
LoadModule usertrack_module modules/mod_usertrack.so
LoadModule unique_id_module modules/mod_unique_id.so
LoadModule setenvif_module modules/mod_setenvif.so
LoadModule mime_module modules/mod_mime.so
LoadModule dav_module modules/mod_dav.so
LoadModule status_module modules/mod_status.so
LoadModule autoindex_module modules/mod_autoindex.so
LoadModule asis_module modules/mod_asis.so
LoadModule info_module modules/mod_info.so
LoadModule dav_fs_module modules/mod_dav_fs.so
LoadModule vhost_alias_module modules/mod_vhost_alias.so
LoadModule negotiation_module modules/mod_negotiation.so
LoadModule dir_module modules/mod_dir.so
LoadModule imap_module modules/mod_imap.so
LoadModule actions_module modules/mod_actions.so
LoadModule speling_module modules/mod_speling.so
LoadModule userdir_module modules/mod_userdir.so
LoadModule alias_module modules/mod_alias.so
LoadModule rewrite_module modules/mod_rewrite.so
LoadModule proxy_module modules/mod_proxy.so
LoadModule proxy_ftp_module modules/mod_proxy_ftp.so
LoadModule proxy_http_module modules/mod_proxy_http.so
LoadModule proxy_connect_module modules/mod_proxy_connect.so

#php4 APACHE MODULE
#Linhas necessarias para rodar PHP
LoadModule php4_module modules/libphp4.so
AddType application/x-httpd-php .php .inc


<IfModule prefork.c>
LoadModule cgi_module modules/mod_cgi.so
</IfModule>

<IfModule worker.c>
LoadModule cgid_module modules/mod_cgid.so
</IfModule>

#Geralmente apache ou nobody
User apache
Group apache

#Email do admin do servidor
ServerAdmin webmaster@meuservidor.com

#Dominio padrao
ServerName www.meuservidor.com

UseCanonicalName Off

#Pasta de arquivos para o dominio padrao
DocumentRoot "/www"
<Directory />
    #Se quiser executar CGI/PERL em todos os diretorios
    #basta adicionar +ExecCGI na TAG Options, ou colocar All para todas as opcoes
    Options All
    AllowOverride All
</Directory>
<Directory "/www">
    #A opcao Indexes funciona da seguinte maneira:
    #se o diretorio nao tiver um INDEX ele listara seu conteudo.
    Options Indexes FollowSymLinks MultiViews
    AllowOverride None
    Order allow,deny
    Allow from all
</Directory>

<Directory "/www/cgi-bin">
    AllowOverride None
    Options None
    Order allow,deny
    Allow from all
</Directory>
<LocationMatch "^/$>
    Options -Indexes
    ErrorDocument 403 /error/noindex.html
</LocationMatch>
<IfModule mod_userdir.c>
    UserDir disable
    #UserDir indica para o apache que:
    #se tentar acessar por exemplo: www.meuservidor.com/~alexandre
    #ele vai ler o conteudo do diretorio: /home/alexandre/public_html
    #esta diretiva eh interessante para provedores de internet
    #que querem disponibilizar espaço para os assinantes
    UserDir /home/*/public_html
</IfModule>

#Arquivo de INDEX que o apache vai reconhecer
DirectoryIndex index.html index.html.var index.php

AccessFileName .htaccess
<Files ~ "^\.ht">
    Order allow,deny
    Deny from all
</Files>
TypesConfig /etc/mime.types
DefaultType text/plain
<IfModule mod_mime_magic.c>
    MIMEMagicFile conf/magic
</IfModule>
HostnameLookups Off

#Log de erros do dominio padrao
ErrorLog logs/error_log
LogLevel warn
LogFormat "%h %l %u %t \"%r\" %>s %b \"%{Referer}i\" \"%{User-Agent}i\"" combined
LogFormat "%h %l %u %t \"%r\" %>s %b" common
LogFormat "%{Referer}i -> %U" referer
LogFormat "%{User-agent}i" agent

#Custom log do dominio padrao
CustomLog logs/access_log combined

#Aliases padroes do Apache
Alias /icons/ "/var/www/icons/"
<Directory "/var/www/icons">
    Options Indexes MultiViews
    AllowOverride None
    Order allow,deny
    Allow from all
</Directory>
IndexOptions FancyIndexing VersionSort NameWidth=*
AddIconByEncoding (CMP,/icons/compressed.gif) x-compress x-gzip
AddIconByType (TXT,/icons/text.gif) text/*
AddIconByType (IMG,/icons/image2.gif) image/*
AddIconByType (SND,/icons/sound2.gif) audio/*
AddIconByType (VID,/icons/movie.gif) video/*
AddIcon /icons/binary.gif .bin .exe
AddIcon /icons/binhex.gif .hqx
AddIcon /icons/tar.gif .tar
AddIcon /icons/world2.gif .wrl .wrl.gz .vrml .vrm .iv
AddIcon /icons/compressed.gif .Z .z .tgz .gz .zip
AddIcon /icons/a.gif .ps .ai .eps
AddIcon /icons/layout.gif .html .shtml .htm .pdf
AddIcon /icons/text.gif .txt
AddIcon /icons/c.gif .c
AddIcon /icons/p.gif .pl .py
AddIcon /icons/f.gif .for
AddIcon /icons/dvi.gif .dvi
AddIcon /icons/uuencoded.gif .uu
AddIcon /icons/script.gif .conf .sh .shar .csh .ksh .tcl
AddIcon /icons/tex.gif .tex
AddIcon /icons/bomb.gif core
AddIcon /icons/back.gif ..
AddIcon /icons/hand.right.gif README
AddIcon /icons/folder.gif ^^DIRECTORY^^
AddIcon /icons/blank.gif ^^BLANKICON^^
DefaultIcon /icons/unknown.gif
ReadmeName README.html
HeaderName HEADER.html
IndexIgnore .??* *~ *# HEADER* README* RCS CVS *,v *,t

AddEncoding x-compress Z
AddEncoding x-gzip gz tgz
AddLanguage da .dk
AddLanguage nl .nl
AddLanguage en .en
AddLanguage et .et
AddLanguage fr .fr
AddLanguage de .de
AddLanguage he .he
AddLanguage el .el
AddLanguage it .it
AddLanguage ja .ja
AddLanguage pl .po
AddLanguage kr .kr
AddLanguage pt .pt
AddLanguage nn .nn
AddLanguage no .no
AddLanguage pt-br .pt-br
AddLanguage ltz .ltz
AddLanguage ca .ca
AddLanguage es .es
AddLanguage sv .se
AddLanguage cz .cz
AddLanguage ru .ru
AddLanguage tw .tw
AddLanguage zh-tw .tw
AddLanguage hr .hr
LanguagePriority pt-br en da nl et fr de el it ja kr no pl pt ltz ca es sv tw
ForceLanguagePriority Prefer Fallback
AddDefaultCharset ISO-8859-1

AddCharset ISO-8859-1  .iso8859-1  .latin1
AddCharset ISO-8859-2  .iso8859-2  .latin2 .cen
AddCharset ISO-8859-3  .iso8859-3  .latin3
AddCharset ISO-8859-4  .iso8859-4  .latin4
AddCharset ISO-8859-5  .iso8859-5  .latin5 .cyr .iso-ru
AddCharset ISO-8859-6  .iso8859-6  .latin6 .arb
AddCharset ISO-8859-7  .iso8859-7  .latin7 .grk
AddCharset ISO-8859-8  .iso8859-8  .latin8 .heb
AddCharset ISO-8859-9  .iso8859-9  .latin9 .trk
AddCharset ISO-2022-JP .iso2022-jp .jis
AddCharset ISO-2022-KR .iso2022-kr .kis
AddCharset ISO-2022-CN .iso2022-cn .cis
AddCharset Big5        .Big5       .big5
AddCharset WINDOWS-1251 .cp-1251   .win-1251
AddCharset CP866       .cp866
AddCharset KOI8-r      .koi8-r .koi8-ru
AddCharset KOI8-ru     .koi8-uk .ua
AddCharset ISO-10646-UCS-2 .ucs2
AddCharset ISO-10646-UCS-4 .ucs4
AddCharset UTF-8       .utf8
AddCharset GB2312      .gb2312 .gb
AddCharset utf-7       .utf7
AddCharset utf-8       .utf8
AddCharset big5        .big5 .b5
AddCharset EUC-TW      .euc-tw
AddCharset EUC-JP      .euc-jp
AddCharset EUC-KR      .euc-kr
AddCharset shift_jis   .sjis

AddType application/x-tar .tgz
AddHandler cgi-script .cgi .pl
AddHandler imap-file map
AddHandler type-map var
AddOutputFilter INCLUDES .shtml

Alias /error/ "/var/www/error/"

<IfModule mod_negotiation.c>
<IfModule mod_include.c>
    <Directory "/var/www/error">
        AllowOverride None
        Options IncludesNoExec
        AddOutputFilter Includes html
        AddHandler type-map var
        Order allow,deny
        Allow from all
        LanguagePriority en es de fr
        ForceLanguagePriority Prefer Fallback
    </Directory>
    ErrorDocument 400 /error/HTTP_BAD_REQUEST.html.var
    ErrorDocument 401 /error/HTTP_UNAUTHORIZED.html.var
    ErrorDocument 403 /error/HTTP_FORBIDDEN.html.var
    ErrorDocument 404 /error/HTTP_NOT_FOUND.html.var
    ErrorDocument 405 /error/HTTP_METHOD_NOT_ALLOWED.html.var
    ErrorDocument 408 /error/HTTP_REQUEST_TIME_OUT.html.var
    ErrorDocument 410 /error/HTTP_GONE.html.var
    ErrorDocument 411 /error/HTTP_LENGTH_REQUIRED.html.var
    ErrorDocument 412 /error/HTTP_PRECONDITION_FAILED.html.var
    ErrorDocument 413 /error/HTTP_REQUEST_ENTITY_TOO_LARGE.html.var
    ErrorDocument 414 /error/HTTP_REQUEST_URI_TOO_LARGE.html.var
    ErrorDocument 415 /error/HTTP_SERVICE_UNAVAILABLE.html.var
    ErrorDocument 500 /error/HTTP_INTERNAL_SERVER_ERROR.html.var
    ErrorDocument 501 /error/HTTP_NOT_IMPLEMENTED.html.var
    ErrorDocument 502 /error/HTTP_BAD_GATEWAY.html.var
    ErrorDocument 503 /error/HTTP_SERVICE_UNAVAILABLE.html.var
    ErrorDocument 506 /error/HTTP_VARIANT_ALSO_VARIES.html.var

</IfModule>
</IfModule>

BrowserMatch "Mozilla/2" nokeepalive
BrowserMatch "MSIE 4\.0b2;" nokeepalive downgrade-1.0 force-response-1.0
BrowserMatch "RealPlayer 4\.0" force-response-1.0
BrowserMatch "Java/1\.0" force-response-1.0
BrowserMatch "JDK/1\.0" force-response-1.0
BrowserMatch "Microsoft Data Access Internet Publishing Provider" redirect-carefully
BrowserMatch "^WebDrive" redirect-carefully

#Estas diretivas permitem que voce acesse www.meuservidor.com/server-status ou www.meuservidor.com/server-info
#e obtenha informacoes sobre o apache, note que apenas alguns ips sao permitidos
<Location /server-status>
    SetHandler server-status
    Order deny,allow
    Deny from all
    Allow from 127.0.0.1, 10.0.0., 192.168.0.
</Location>
<Location /server-info>
   SetHandler server-info
   Order deny,allow
   Deny from all
    Allow from 127.0.0.1, 10.0.0., 192.168.0.
</Location>

#Muitos usuarios utilizam MRTG, aqui seguem algumas diretivas
#que vao forcar o EXPIRE das imagens geradas por ele
#Expire do MRTG
<Files "*-day.png">
        ExpiresActive On
        ExpiresDefault M300
</Files>
<Files "*-week.png">
        ExpiresActive On
        ExpiresDefault M1800
</Files>
<Files "*-month.png">
        ExpiresActive On
        ExpiresDefault M7200
</Files>
<Files "*-year.png">
        ExpiresActive On
        ExpiresDefault M86400
</Files>



#Secao de VIRTUALHOST 
#Aqui vc define um IP que vai usar para o virtualhosting
#Pode usar IP:PORTA ou *:PORTA (esta servira para todos os ips)

NameVirtualHost *:80

#Esta diretiva voce vai definir um dominio virtual
#usarei os dominios meuservidor2.com e meuservidor3.com como exemplo

<VirtualHost *:80>
    ServerAdmin webmaster@meuservidor2.com
    DocumentRoot /meuservidor2
    ServerName meuservidor2.com
    ServerAlias www.meuservidor2.com
    <Directory "/meuservidor2">
        Options Indexes FollowSymLinks
        AllowOverride None
        Order allow,deny
        Allow from all
    </Directory>
    <Directory "/meuservidor2/cgi-bin">
        AllowOverride None
        Options ExecCGI
        Order allow,deny
        Allow from all
    </Directory>
    ErrorLog logs/meuservidor2.com-error_log
    CustomLog logs/meuservidor2.com-access_log common
    #Esta diretiva permite que scripts PHP acessem APENAS arquivos apartir das pastas ESPECIFICAS
    <IfModule mod_php4.c>
        php_admin_value open_basedir "/meuservidor2/:/usr/lib/php:/usr/local/lib/php:/tmp"
    </IfModule>
    ScriptAlias /cgi-bin/ /meuservidor2/cgi-bin/
</VirtualHost>" >> /etc/httpd/conf/httpd.con