#!/bin/bash
firebaseurl="https://noodlehash.firebaseio.com/noodles/"
firebasetoken="Gj7wy8SmcHeBe7Svx1fEKOk6T5dkQbdcPTIIgSg8"
timemsnow=$(($(date +%s%N)/1000000))
timems65minago=$(($(date --date '-65 min' +%s%N)/1000000))
TEMPLOCATION="/var/www/decidz/temp/"
tempfilename="optionsadded_$(date +%Y-%m-%d_%H-%M).json"

# curl -H "Accept: application/json"  "${firebaseurl}.json?auth=${firebasetoken}&orderBy=%22_optiontimestamp%22&startAt=1429807893074&print=pretty" -o "${TEMPLOCATION}${tempfilename}"
curl -H "Accept: application/json"  "${firebaseurl}.json?auth=${firebasetoken}&orderBy=%22_optiontimestamp%22&startAt=${timems65minago}&print=pretty" -o "${TEMPLOCATION}${tempfilename}"
  
