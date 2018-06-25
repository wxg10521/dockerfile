#!/bin/sh

# generate host keys if not present
ssh-keygen -A

# check wether a random root-password is provided
if [ ! -z "${ROOT_PASSWORD}" ] && [ "${ROOT_PASSWORD}" != "root" ]; then
    echo "root:${ROOT_PASSWORD}" | chpasswd
fi
if [ ! -z $"SYNCIP" ];then
	IP2=$SYNCIP
fi
if [ ! -z $"SSHD_PORT" ];then
    sed -i "s/#Port 22/Port $SSHD_PORT/g" /etc/ssh/sshd_config
fi
# do not detach (-D), log to stderr (-e), passthrough other arguments
/usr/bin/supervisord -c /etc/supervisord.conf
exec /usr/local/bin/inotify.sh 
