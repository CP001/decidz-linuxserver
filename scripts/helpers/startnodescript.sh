#!/bin/sh
echo "--> Executing script helpers/startnodescript.sh"
if [ -z "$1" ]; then
  echo "--> no folder name passed"
elif [ -z "$2" ]; then
  echo "--> no script name passed"
else
	if [ $(ps -aux | grep $1/$2 | grep -v grep | wc -l | tr -s '\n') -eq 0 ]; then
		echo "--> Starting $1/$2"
		echo "--> Calling forever start --spinSleepTime 10000 --minUptime 1000 --sourceDir $1 $2"
		export PATH=/usr/local/bin:$PATH
		forever start --spinSleepTime 10000 --minUptime 1000 --sourceDir $1 $2
	else
		echo "--> $1/$2 already running"
	fi
fi



