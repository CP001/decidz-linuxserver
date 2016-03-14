#!/bin/sh
deploymainwebsite websitename gitbranch
if [ -z "$1" ]; then
	echo "no website name passed"
elif [ -z "$2" ]; then
	echo "no git branch passed"
else
	cd /var/www/decidz/gitrepo/decidz-webapp
	git stash
	git pull
	git checkout $1
	npm install
	bower install --allow-root

	update the following file:
	cp /var/www/decidz/gitrepo/decidz-linuxserver/scripts/config/prod/configFile.json /var/www/decidz/gitrepo/decidz-webapp/configFile.json
	#sudo nano /var/www/decidz/gitrepo/decidz-webapp/configFile.json
	# version 0.1.5 last release
	# adventurous-aardvark
	gulp build-config

	cd /var/www/decidz/gitrepo/decidz-linuxserver/scripts/config/
	gulp deploy --type prefirebase --branch master
	#gulp deploy --type int --branch integration
	#gulp deploy --type staging --branch master


	cd /var/www/decidz/websites/prefirebase/www
	# firebase deploy
	/usr/bin/firebase deploy


	if [ $(ps -aux | grep $1/$2 | grep -v grep | wc -l | tr -s '\n') -eq 0 ]; then

	export PATH=/usr/local/bin:$PATH
		forever start --spinSleepTime 10000 --minUptime 1000 --sourceDir $1 $2 >> /var/www/decidz/logs/node/$2.log 2>&1
	fi
fi



