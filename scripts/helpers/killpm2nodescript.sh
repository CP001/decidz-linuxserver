#!/bin/sh
echo "--> Executing script helpers/killpm2nodescript.sh"
if [ -z "$1" ]; then
  echo "--> no script id passed"
else
  if [ $(pm2 list | grep $1 | wc -l | tr -s '\n') -eq 0 ]; then
    echo "--> $1 not found in pm2"
  else
    echo "--> pm2 delete $1"
    pm2 delete $1  
  fi
fi
