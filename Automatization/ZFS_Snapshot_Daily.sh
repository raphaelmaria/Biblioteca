#!/bin/sh
# Snapshot Automatic
# Criado em 11 de Novembro de 2019
# Por Raphael Maria
# Versao 1
# Local de Armazenamento /etc/cron.daily

echo "
#!/bin/sh
# Snapshot Automatic
# Criado em 11 de Novembro de 2019
# Por Raphael Maria
# Versao 1
#
exec zfs-auto-snapshot --quiet --syslog --label=daily --keep=31 //" >> /etc/cron.daily/zfs_snapshot_daily.sh

chmod +X /etc/cron.daily/zfs_snapshot_daily.sh
ls -la /etc/cron.daily
chmod 777 /etc/cron.daily/zfs_snapshot_daily.sh
ls -la /etc/cron.daily