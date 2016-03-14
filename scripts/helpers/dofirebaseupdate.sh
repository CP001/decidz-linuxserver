#!/bin/bash
if [ -z "$1" ]; then
  echo "no firebase key"
elif [ -z "$2" ]; then
  echo "no data"
else
  cd /var/www/decidz/scripts/
  node dofirebaseupdate.js "$1" "$2"

fi
