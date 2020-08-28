#!/bin/sh
/usr/local/bin/monitor.sh &
exec nginx -g 'daemon off;'
