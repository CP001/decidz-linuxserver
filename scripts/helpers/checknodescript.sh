#!/bin/sh
if [ -z "$1" ]; then
  echo "--> no folder name passed"
elif [ -z "$2" ]; then
  echo "--> no script name passed"
elif [ -z "$3" ]; then
  echo "--> no site name passed"
else
	cd /var/www/decidz/scripts/
	if [ $(ps -aux | grep $1/$2 | grep -v grep | wc -l | tr -s '\n') -eq 0 ]; then
		node upsertfirebaserecord.js "/nodestatus/$3"  "0"
	else
		node upsertfirebaserecord.js "/nodestatus/$3"  "1"
	fi
fi



