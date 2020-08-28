#!/bin/sh
STATUS=`ps -ef |grep -v grep|grep -c inotifywait`
if [ ${STATUS} -lt 1 ];then
if [ $INOTIFY_DIR ];then
	if [ ! -e $INOTIFY_DIR ];then
		mkdir $INOTIFY_DIR
	fi
else
	INOTIFY_DIR="/nginx/conf.d"
fi
if [ ! -e /nginx/logs ];then
	mkdir /nginx/logs
fi
inotifywait -rmq -e create,delete,modify,move $INOTIFY_DIR | while read line ;do
	nginx -t
	if [ $? == '0' ];then
		nginx -s reload
		echo  `date +%F" "%T` "$line -------reload" >> /nginx/logs/reload$(date +%Y%m).log
	fi
done
fi
