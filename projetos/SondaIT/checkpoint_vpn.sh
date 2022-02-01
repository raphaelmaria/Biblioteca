#!/bin/sh
ARCHIVE_OFFSET=80

TMP_DIR=/tmp

LogEvent()
{
	echo $3
	if [ $1 = 1 ]
	then
		exit $2
	fi
}

ExtractSNX()
{
	tail -n +$1 $2 | bunzip2 -c - | (cd ${TMP_DIR}; tar xf -) > /dev/null 2>&1
	if [ ! $? -eq 0 ]
	then
		LogEvent 1 1 "failed to extract archive"
	fi
}

Cleanup()
{
	rm -f ${TMP_DIR}/SNX\ Installer
	rm -f ${TMP_DIR}/snx
	rm -f ${TMP_DIR}/snx_uninstall.sh
	exit 0
}

IsNotSupperUser()
{
	if [ `id -u` != 0 ]
	then
		return 0
	fi

	return 1
}


trap Cleanup 2
trap Cleanup 3
trap Cleanup 13
trap Cleanup 15

COMMAND_TO_RUN="install --owner=root --group=root --mode=u=rxs,g=x,o=x snx /usr/bin/snx; install --owner=root --group=root --mode=u=rx,g=rx,o=rx snx_uninstall.sh /usr/bin/snx_uninstall; install --directory --owner=root --group=root --mode=u=rwx /etc/snx; install --directory --owner=root --group=root --mode=u=rwx /etc/snx/tmp"

# Extract the SNX utility
ExtractSNX "${ARCHIVE_OFFSET}" "$0"

# Check if supper user permissions are required
if IsNotSupperUser
then
	echo "The installation script requires root permissions"
	echo "Please provide the root password"
fi

# Change directory to ${TMP_DIR}
cd ${TMP_DIR}
ln -s `which su` SNX\ Installer
PATH="${PATH}:."
SNX\ Installer -c "${COMMAND_TO_RUN}"
STATUS=$?

if [ ${STATUS} = 0 ]
then
	echo "Installation successfull"
	mkdir -p ${TMP_DIR}/SNXNM
	snx usage | grep -o -m 1 -E [0-9]+ > ${TMP_DIR}/SNXNM/ver.ini
else
	echo "Installation failed"
fi


Cleanup

exit 0