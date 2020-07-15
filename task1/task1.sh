#!/bin/bash

function ascending_order(){
	ls -m "$1"
}

function descending_order(){
        ls -rm "$1"
}

while [[ $# -gt 0 ]]
do
key="$1"

case $key in
	-h|--help)
		echo "This bash script prints folder content in ascending or descending order
		Manual:
		-p|--path		Folder path
		-a|--ascending		Ascending order
		-d|--descending 	Descending order
		
		Example: ./task1 -p ./Excercise/ -a
			 ./task1 -p ./Excercise/ -d"
		exit 1
		;;
	-p|--path)
		FOLDERPATH="$2"
		shift # past argument
		shift # past value
		;;
	-a|--ascending)
		ORDER=true
		shift # past value
		;;
	-d|--descending)
		ORDER=false
		shift # past value
		;;
	*)    # unknown option
		echo "Try again with sorting argument, use -h/--help for more details"
		exit 1
		;;
esac
done

if [ "$ORDER" = true ]; then
	ascending_order "$FOLDERPATH"
elif [ "$ORDER" = false ]; then
	descending_order "$FOLDERPATH"
else
	echo "Try again with sorting argument, use -h/--help for more details"
fi
