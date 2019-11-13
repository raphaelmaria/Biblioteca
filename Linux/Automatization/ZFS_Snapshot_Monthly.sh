#!/bin/sh
# Snapshot Automatic
# Criado em 11 de Novembro de 2019
# Por Raphael Maria
# Versao 1
# Local de Armazenamento /etc/cron.monthly

echo "
# Snapshot Automatic
# Criado em 11 de Novembro de 2019
# Por Raphael Maria
# Versao 1
#
exec zfs-auto-snapshot --quiet --syslog --label=monthly --keep=12 //" >> /etc/cron.monthly/zfs_snapshot_monthly.sh

chmod +X /etc/cron.monthly/zfs_snapshot_monthly.sh
ls -la /etc/cron.monthly
chmod 777 /etc/cron.monthly/zfs_snapshot_monthly.sh
ls -la /etc/cron.monthly