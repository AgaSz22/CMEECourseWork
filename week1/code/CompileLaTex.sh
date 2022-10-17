#!/bin/bash

if [ $# -eq 0 ]   #Checking whether the user provided an argument
    then 
        echo "Please provide a file argument"
    exit
fi

if [[ $1 == *.tex ]]  ##Checking whether the input file contains .tex extension. If not, then it adds the .tex extension.
then
    pdflatex $1
    bibtex $(basename "$1" .tex)
    pdflatex $1
    pdflatex $1
    evince $(basename "$1" .tex).pdf &
else
    pdflatex $1.tex
    bibtex $1
    pdflatex $1.tex
    pdflatex $1.tex
    evince $1.pdf & 
fi

## Cleanup
rm *.aux
rm *.log
rm *.bbl
rm *.blg

exit