#!/bin/sh
# Snapshot Automatic
# Criado em 11 de Novembro de 2019
# Por Raphael Maria
# Versao 1
# Local de Armazenamento /etc/cron.hourly

echo "
# Snapshot Automatic
# Criado em 11 de Novembro de 2019
# Por Raphael Maria
# Versao 1
#
exec zfs-auto-snapshot --quiet --syslog --label=hourly --keep=24 //" >> /etc/cron.hourly/zfs_snapshot_hourly.sh

chmod +X /etc/cron.hourly/zfs_snapshot_hourly.sh
ls -la /etc/cron.hourly/
chmod 777 /etc/cron.hourly/zfs_snapshot_hourly.sh
ls -la /etc/cron.hourly/
