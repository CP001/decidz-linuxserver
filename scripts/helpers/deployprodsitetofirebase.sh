#!/bin/bash
echo "--> Executing script helpers/deployprodsitetofirebase.sh"
echo "--> Changing to folder /var/www/decidz/websites/prefirebase/www"
cd /var/www/decidz/websites/prefirebase/www
echo "--> Running firebase deploy"
/usr/bin/firebase deploy
