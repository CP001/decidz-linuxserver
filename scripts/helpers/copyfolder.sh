#!/bin/bash
echo "--> Executing script helpers/copyfolder.sh"
if [ -z "$1" ]; then
  echo "--> no source folder"
elif [ -z "$2" ]; then
  echo "--> no destination folder"
elif [ -z "$3" ]; then
  echo "--> no git branch specified"
else
  echo "--> Removing folder $2"
  rm -R $2
  echo "--> Creating folder $2"
  mkdir -p $2
  echo "--> Changing to folder $1"
  cd $1
  echo "--> Executing git checkout $3" 
  git checkout $3
  echo "--> Copying folder $1 to $2" 
  cp -R $1* $2
  echo "--> Opening perms to $2"
  sudo chmod -R 777 $2
fi
