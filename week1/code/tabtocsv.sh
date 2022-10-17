#!/bin/sh
# Author: Agnes Szwarczynska; ass122@.ac.uk
# Script: tabtocsv.sh
# Description: substitute the tabs in the files with commas
#
# Saves the output into a .csv file
# Arguments: 1 -> tab delimited file
# Date: Oct 2019

if [ $# -eq 0 ]
    then 
        echo "Please provide a second file"
    exit 

fi
echo "Creating a comma delimited version of $1 ..."
cat ../data/$1 | tr -s "\t" "," >> ../results/${1%.txt}.csv
echo "Done!"
    exit
