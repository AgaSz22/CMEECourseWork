#!/bin/bash

if [ $# -eq 0 ]   #Checking whether the user provided an argument
    then 
        echo "Please provide a file argument"
    exit
fi

if [ ! -f $1 ]     #Checking whether the user provided exisitng files
    then 
        echo "Ooops.'$1' is not a file"
    exit 
fi

if [ -f $1 ]      #Printing number of lines in a file
    then
        NumLines=`wc -l < $1`
        echo "The file $1 has $NumLines lines"
    echo
fi

exit