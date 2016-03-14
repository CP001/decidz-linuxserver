#!/bin/bash
echo "--> Executing script helpers/clearfolder.sh"
if [ -z "$1" ]; then
  echo "--> no folder specified"
else
  echo "--> Removing folder $1"
  rm -R $1
  echo "--> Creating folder $1"
  mkdir -p $1
fi
