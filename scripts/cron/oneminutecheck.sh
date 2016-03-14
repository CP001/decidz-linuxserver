#!/bin/bash
lockfile=/var/www/decidz/scripts/oneminutecheck.lock
if ( set -o noclobber; echo "$$" > "$lockfile") 2> /dev/null; then
    trap 'rm -f "$lockfile"; exit $?' INT TERM EXIT
    # this instance of the script has a file lock so its the only instance running
    echo "--> Script locked and loaded";

    echo "one minute check"
#    curl "https://api.decidz.com/checkforrecentactivity/"
#    curl "http://api.staging.decidz.com/checkforrecentactivity/"
#    curl "http://api.int.decidz.com/checkforrecentactivity/"

    rm -f "$lockfile"
    trap - INT TERM EXIT
    echo "--> Script complete";
else
    echo "--> Lock Exists: $lockfile owned by $(cat $lockfile)"
fi
