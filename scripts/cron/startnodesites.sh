#!/bin/bash
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
SCRIPTSLOCATION="/var/www/decidz/scripts"
lockfile=/var/www/decidz/scripts/startingnodesites.lock

# =======================================================================================================================
# START OF MAIN SCRIPT
# =======================================================================================================================
if ( set -o noclobber; echo "$$" > "$lockfile") 2> /dev/null; then

	trap 'rm -f "$lockfile"; exit $?' INT TERM EXIT
	# this instance of the script has a file lock so its the only instance running
	echo "--> Script locked and loaded";
	cd /var/www/decidz/scripts/
	node startnodeservers.js

	# clean up after yourself, and release your lock file
	rm -f "$lockfile"
	trap - INT TERM EXIT
	echo "--> Script complete";
else
	echo "--> Lock Exists: $lockfile owned by $(cat $lockfile)"
fi
