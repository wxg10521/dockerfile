#!/bin/sh
if [ ! $INTERVAL ];then
	INTERVAL=15
fi
ISTATUS=`ps -ef |grep -v grep|grep -c /usr/local/bin/inotify.sh`
while true;do
if [ $ISTATUS -eq 0 ];then
	/usr/local/bin/inotify.sh
	sleep $INTERVAL 
fi
done
