#!/bin/bash
if [ -z "$1" ]; then
  echo "No recipient"
elif [ -z "$2" ]; then
  echo "no message"
else
  cd /var/www/decidz/scripts/
  node sendslackmessage.js "$1" "$2"

fi
