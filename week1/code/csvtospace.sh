#!/bash/bin

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

if [ $# -eq 1 ]  #Creating a file with the .txt extension
    then
        echo "Creating a space separated version of $1 ..."
        cat $1 | tr "," " " >>../results/"$(basename "$1" .csv).txt"
    echo "Done!"
fi

exit