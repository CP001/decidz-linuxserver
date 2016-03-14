#!/bin/bash
echo "--> Executing script helpers/dobowerinstall.sh"
if [ -z "$1" ]; then
  echo "--> no folder passed"
else
	echo "--> changing to folder $1"
	cd $1
	# install npm packages for dev, etc
	echo "--> running bower install"
	sudo bower install --allow-root
	echo "--> running bower update"
	bower update --allow-root
fi
