#!/bin/sh

#This introduces you to the $USER (same as $USERNAME) environmental variable.

MSG1="Hello"    
MSG2=$USER
echo "$MSG1 $MSG2"
echo "Hello $USER"
echo