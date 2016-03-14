#!/bin/bash
echo "--> Executing script helpers/deployfirebasejson.sh"
echo "--> Copying /var/www/decidz/scripts/config/templates/firebase.json to /var/www/decidz/websites/prefirebase/www/firebase.json"
cp /var/www/decidz/scripts/config/templates/firebase.json /var/www/decidz/websites/prefirebase/www/firebase.json

