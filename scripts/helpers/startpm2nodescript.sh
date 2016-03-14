#!/bin/sh
echo "--> Executing script helpers/startpm2nodescript.sh"
if [ -z "$1" ]; then
  echo "--> no script name passed"
elif [ -z "$2" ]; then
  echo "--> no script id passed"
elif [ -z "$3" ]; then
  echo "--> no folder passed"
else
	if [ $(pm2 list | grep $2 | wc -l | tr -s '\n') -eq 0 ]; then
		echo "--> Starting $1/$2"
		echo "--> changing to folder $3"
		cd $3
		echo "--> Calling pm2 start $1 --name=\"$2\"" --no-vizion
#		export PATH=/usr/local/bin:$PATH
		sudo pm2 start $1 --name="$2" --no-vizion
	else
		echo "--> $2 already running"
	fi
fi
