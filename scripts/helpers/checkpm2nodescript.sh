#!/bin/sh
if [ -z "$1" ]; then
  echo "--> no script passed"
else
	cd /var/www/decidz/scripts/
	if [ $(pm2 list | grep $1 | grep -v grep | wc -l | tr -s '\n') -eq 0 ]; then
		node upsertfirebaserecord.js "/nodestatus/$1"  "0"
	else
		node upsertfirebaserecord.js "/nodestatus/$1"  "1"
	fi
fi
