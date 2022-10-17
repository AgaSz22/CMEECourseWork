#!/bin/bash

if [ $# -eq 0 ]   #Checking whether the user provided an argument
    then 
        echo "Please provide a .tiff file as an argument"
    exit
fi

if [ ! -f $1 ]    #Checking whether the user provided exisitng files
    then 
        echo "Ooops.'$1' is not a file"
    exit 
fi

if [ -f $1 ]     #Converting a .tiff file to .png
    then 
        for f in *.tiff;   
            do  
                echo "Converting $f"; 
                convert "$f"  "$(basename "$f" .tiff).png"; 
                echo "Done!"
                mv  *.png ../results/
            done
fi
    exit