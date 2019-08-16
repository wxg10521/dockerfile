#!/bin/sh

# generate host keys if not present
ssh-keygen -A

# check wether a random root-password is provided
if [ ! -z "${ROOT_PASSWORD}" ] && [ "${ROOT_PASSWORD}" != "root" ]; then
    echo "root:${ROOT_PASSWORD}" | chpasswd
fi
add_rsync(){
    NODE=$1
    ADDNODE=`eval echo '$'RSYNC_NAME"$NODE"`
    sed -i "\$a $ADDNODE" /etc/rsyncd.conf
    ADDPATH=`eval echo '$'RSYNC_PATH"$NODE"`
    sed -i "\$a path = /$ADDPATH" /etc/rsyncd.conf
cat << ENDOF >> /etc/rsync.conf
comment = Mirror to test
ignore errors = yes
use chroot = no
munge symlinks = no
read only = no
ENDOF
}
if [  $SSHD_PORT ];then
    sed -i "s/#Port 22/Port $SSHD_PORT/g" /etc/ssh/sshd_config
fi
if [ ! -z $"RSYNC_NAME" ];then
    sed -i 's/rsync1/'$RSYNC_NAME'/' /etc/rsyncd.conf
fi
if [ ! -z $DIRNODE ];then
    for i in `seq 2 $DIRNODE`;do
        add_rsync $i
    done
fi
if [  $SER_REMOTEIP ];then
    sed -i "s/172.17.0.3/$SER_REMOTEIP/g" /usr/local/sersync/confxml.xml
fi
if [  $SER_REMOTENAME ];then
    sed -i "s/test/$SER_REMOTENAME/g" /usr/local/sersync/confxml.xml
fi
if [  $SER_LOCALPATH ];then
    sed -i "s#/rsyncdir#$SER_REMOTEPATH#g" /usr/local/sersync/confxml.xml
fi
if [  $SER_COMM ];then
    sed -i "s/-artuzP/$SER_COMM/g" /usr/local/sersync/confxml.xml
fi      
# do not detach (-D), log to stderr (-e), passthrough other arguments
if [ $ROLE == "rsync" ];then 
	/usr/bin/rsync --daemon /etc/rsyncd.conf
elif [ $ROLE == "sersync" ];then 
	/usr/local/sersync/sersync2 -r -d -o /usr/local/sersync/confxml.xml
else
	exit 1
fi
exec /usr/sbin/sshd -D -e "$@"
