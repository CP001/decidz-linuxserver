#!/bin/bash
echo "--> Executing script helpers/donmpinstall.sh"
if [ -z "$1" ]; then
  echo "--> no folder passed"
else
	echo "--> changing to folder $1"
	cd $1
	if [ -z "$2" ]; then
		# install npm packages for dev, etc
		echo "--> running npm install"
		sudo npm install
	else
		if [[ "$2" == "prod" ]]; then
			# install npm packages for production
			echo "--> running npm install --production"
			sudo npm install --production
		else
			# install npm packages for dev, etc
			echo "--> running npm install"
			sudo npm install
		fi
	fi
fi
