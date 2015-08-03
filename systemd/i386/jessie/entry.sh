#!/bin/bash

HOSTNAME=$(cat /etc/hostname)
echo "127.0.1.1 $HOSTNAME" >> /etc/hosts
hostname $HOSTNAME

if [ "$INITSYSTEM" = "on" ]; then
	GREEN='\033[0;32m'
	echo -e "${GREEN}Systemd init system enabled."
	env > /etc/docker.env

	echo -e "#!/bin/bash\n exec $@" > /etc/resinApp.cmd
	chmod +x /etc/resinApp.cmd

	mount -t devtmpfs none /dev

	exec /sbin/init quiet
else
	mount -t devtmpfs none /dev
	udevd & 
	udevadm trigger &> /dev/null
	
	CMD=$(which $1)
	shift
	exec "$CMD" "$@"
fi