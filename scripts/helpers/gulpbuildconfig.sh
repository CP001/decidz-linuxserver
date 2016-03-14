#!/bin/bash
echo "--> Executing script helpers/gulpbuildconfig.sh"
if [ -z "$1" ]; then
  echo "--> no folder passed"
else
	echo "--> changing to folder $1"
	cd $1
	echo "--> running gulp build-config"
	sudo gulp build-config
fi
