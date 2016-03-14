#!/bin/bash
echo "--> Executing script helpers/pullgitrepodown.sh"
if [ -z "$1" ]; then
  echo "--> no git repo folder passed"
elif [ -z "$2" ]; then
  echo "--> no branch passed"
else
  echo "--> Changing to folder $1"
  cd $1
  echo "--> Executing git stash"
  sudo git stash
  echo "--> Executing git pull"
  sudo git pull
  echo "--> Changing branch to $2"
  sudo git checkout $2
  echo "--> Executing second git pull against branch"
  sudo git pull
fi
