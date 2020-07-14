#!/bin/bash

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
		shift
		;;
	-p|--path)
		FOLDERPATH="$2"
		shift # past argument
		shift # past value
		;;
	*)    # unknown option
		POSITIONAL+=("$1") # save it in an array for later
		shift # past argument
		;;
esac
done
DUPLICATES_OUTPUT=$(find $FOLDERPATH ! -empty -type f -exec md5sum {} + | sort | uniq  -w32 -D)
DUPLICATES_CNT=$(echo "$DUPLICATES_OUTPUT" | wc -l)
if [ $DUPLICATES_CNT -ge 2 ]; then

	echo "$DUPLICATES_CNT Duplicate files were found.
	Each duplicate files group seperated with a new line:"
	MD5_RES=$(echo "$DUPLICATES_OUTPUT" | awk '{print $1}')
	FILENAME=$(echo "$DUPLICATES_OUTPUT" | awk '{print $2}')
	
	# creating array from md5 output:
	oldIFS="$IFS"
	IFS='
	'
	IFS=${IFS:0:1} # this is useful to format your code with tabs
	lines_md5=( $MD5_RES )
	IFS="$oldIFS"
        # creating array from file output:
        oldIFS="$IFS"

	IFS='
        '
        IFS=${IFS:0:1} # this is useful to format your code with tabs
	files_line=( $FILENAME )
        IFS="$oldIFS"


	CNT=0
	
	DUPFILES=0
	LAST_DUP=$lines_md5[$CNT]
	for line in "${lines_md5[@]}"
	do
		if [ ${lines_md5[$CNT]} != $LAST_DUP ]; then
                        printf "\n"
#			DUPFILES=$(($DUPFILES + 1))
#			echo "${lines_md5[$CNT]} not equal"
#			printf "\n"
		fi
		echo "${files_line[$CNT]}"
		LAST_DUP=${lines_md5[$CNT]}
		CNT=$(($CNT + 1))
	done
	echo "$DUPFILES"
fi	
