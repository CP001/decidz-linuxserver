#!/bin/sh
echo "--> Executing script helpers/killnodescript.sh"
if [ -z "$1" ]; then
  echo "--> no script name passed"
else
  echo "--> pkilling $1 processes"
  pkill -f $1
fi
