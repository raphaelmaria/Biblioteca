#!/bin/bash

apt-get update -y
apt-get install epel-release -y
apt-get install centos-release-scl -y
apt-get install rh-python35 -y
apt-get install git gcc wget nodejs-less libxslt-devel bzip2-devel openldap-devel libjpeg-devel freetype-devel -y


useradd -m -U -r -d /opt/odoo -s /bin/bash odoo
apt-get list postgresql*
apt-get install https://download.postgresql.org/pub/repos/apt-get/9.6/redhat/rhel-7-x86_64/pgdg-redhat96-9.6-3.noarch.rpm -y
apt-get install postgresql96 postgresql96-server postgresql96-contrib postgresql96-libs -y
/usr/pgsql-9.6/bin/postgresql96-setup initdb
systemctl start postgresql-9.6.service
systemctl enable postgresql-9.6.service
cd /opt
wget https://downloads.wkhtmltopdf.org/0.12/0.12.5/wkhtmltox-0.12.5-1.centos7.x86_64.rpm
apt-get localinstall wkhtmltox-0.12.5-1.centos7.x86_64.rpm -y

su - odoo
git clone https://www.github.com/odoo/odoo --depth 1 --branch 12.0 /opt/odoo/odoo12
scl enable rh-python35 bash
cd /opt/odoo
python3 -m venv odoo12-venv
source odoo12-venv/bin/activate
pip install --upgrade pip
pip3 install wheel
pip3 install -r odoo12/requirements.txt
deactivate && exit


mkdir /opt/odoo/odoo12-custom-addons
chown odoo: /opt/odoo/odoo12-custom-addons
echo "[options]
#; This is the password that allows database operations:
admin_passwd = master_password
db_host = False
db_port = False
db_user = odoo
db_password = False
addons_path = /opt/odoo/odoo12/addons
#; You can enable log file with uncommenting the next line
#; logfile = /var/log/odoo12/odoo.log
#; If you are using custom modules
#; addons_path = /opt/odoo/odoo12/addons,/opt/odoo/odoo12-custom-addons" >> /etc/odoo.conf


echo "[Unit]
Description=Odoo12
Requires=postgresql-9.6.service
After=network.target postgresql-9.6.service

[Service]
Type=simple
SyslogIdentifier=odoo12
PermissionsStartOnly=true
User=odoo
Group=odoo
ExecStart=/usr/bin/scl enable rh-python35 -- /opt/odoo/odoo12-venv/bin/python3 /opt/odoo/odoo12/odoo-bin -c /etc/odoo.conf
StandardOutput=journal+console

[Install]
WantedBy=multi-user.target" >> /etc/systemd/system/odoo12.service

systemctl daemon-reload
systemctl start odoo12
systemctl status odoo12
systemctl enable odoo12
journalctl -u odoo12

firewall-cmd --get-default-zone
firewall-cmd --set-default-zone=public
firewall-cmd --permanent --add-port=8069/tcp
firewall-cmd --permanent --add-port=8080/tcp
firewall-cmd --permanent --add-port=80/tcp
firewall-cmd --reload
firewall-cmd --list-all