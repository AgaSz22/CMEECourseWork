#!/bin/bash

if [ $# -eq 0 ]   #Checking whether the user provided appropriate number of arguments
    then 
        echo "Please provide two arguments for files you would like to merge"
    exit 
elif [ $# -eq 1 ]
    then 
        echo "Please provide a second file argument"
    exit
elif [ $# -eq 2 ]
	then
		echo "The output file argument is missing"
	exit
fi

if [ ! -f $1 ]     #Checking whether the user provided exisitng files
    then 
        echo "Ooops.'$1' is not a file"
    exit 
elif [ ! -f $2 ]
	then 
        echo "Ooops.'$2' is not a file"
    exit
fi

cat ../data/$1 > ../results/$3    #Concatenating files provided by the user and displaying the final output
cat ../data/$2 >> ../results/$3
echo "Merged file is"
cat ../results/$3
