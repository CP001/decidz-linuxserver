#!/bin/bash
firebaseurl="https://noodlesoup.firebaseio.com/"
firebasetoken="PtiomPGXrQI7r9Z1BKTrN01CsyzjbevTGIvjnLZG"
backupfolder="/var/www/decidz/firebasebackups/"
tempfilename="firebase_$(date +%Y-%m-%d_%H-%M)"
backupemailaddress="noodlesoupbackup@gmail.com"
curl -H "Accept: application/json"  "${firebaseurl}.json?auth=${firebasetoken}" -o "${backupfolder}${tempfilename}.json"
zip -j "${backupfolder}${tempfilename}.zip" "${backupfolder}${tempfilename}.json"
rm  "${backupfolder}${tempfilename}.json"
echo "Firebase Backup attached" | mutt -a "${backupfolder}${tempfilename}.zip" -s "Noodlesoup Firebase Backup" -- $backupemailaddress

