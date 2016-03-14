#!/bin/bash
echo "--> Executing script helpers/rungulptodeplysite.sh"
if [ -z "$1" ]; then
  echo "--> no deployment folder specified"
elif [ -z "$2" ]; then
  echo "--> no site specified"
elif [ -z "$3" ]; then
  echo "--> no git branch specified"
else
  echo "--> changing to folder $1"
  cd $1
  echo "--> Executing gulp deploy --type $2 --branch $3"
  sudo gulp deploy --type $2 --branch $3
fi
