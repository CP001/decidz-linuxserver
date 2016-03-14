#!/bin/bash
echo "--> Executing script helpers/templatecachehack.sh"
if [ -z "$1" ]; then
  echo "--> no environment specified"
else
  echo "Apending file /var/www/decidz/gitrepo/decidz-webapp/app/common/templates.js to /var/www/decidz/websites/$1/www/app/js/app-*.js"
  cat  /var/www/decidz/gitrepo/decidz-webapp/app/common/templates.js >> /var/www/decidz/websites/$1/www/app/js/app-*.js
fi

