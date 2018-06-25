#/bin/bash

if [ ! -e /var/log/inotify/ ];then
	mkdir /var/log/inotify/
fi
if [ ! -e /syncdir ];then
	mkdir /syncdir
fi
UNISON=`ps -ef |grep -v grep|grep -c inotifywait`
if [ ${UNISON} -lt 1 ]
then
src2="/syncdir/"
dst2="/syncdir/"
inotifywait -mrq -e create,delete,modify,move $src2 | while read line
do
unison -batch $src2 ssh://root@$SYNCIP:$SSHD_PORT/$dst2
echo -n "$line " >> /var/log/inotify/inotify$(date +%u).log
echo ` date +%F %T " " -f1-4` >> /var/log/inotify/inotify$(date +%u).log
done
fi
