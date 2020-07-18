#!/bin/bash

while [[ $# -gt 0 ]]
do
key="$1"

case $key in
	-h|--help)
		echo "This bash script checks for files that are duplicates (equal data), even if they have a different name, and does so for directory specified by the user
		Manual:
		-p|--path		Folder path

		Example: ./task3.sh -p ./test_duplicate/"
		exit 1
		;;
	-p|--path)
		FOLDERPATH="$2"
		shift # past argument
		shift # past value
		;;
	*)    # unknown option
		echo "use -h/--help for more detials"
		exit 1
		;;
esac
done
# validating user input before starting check relevant file duplicates
if [ -z ${FOLDERPATH+x}  ]; then 
	echo "use -h/--help for more detials"
	exit 1
else
	DUPLICATES_OUTPUT=$(find $FOLDERPATH ! -empty -type f -exec md5sum {} + | sort | uniq  -w32 -D)
	DUPLICATES_CNT=$(echo "$DUPLICATES_OUTPUT" | wc -l)
	if [ $DUPLICATES_CNT -ge 2 ]; then
	
		echo "$DUPLICATES_CNT Duplicate files were found.
Each duplicate files group seperated with a new line:"
		MD5_RES=$(echo "$DUPLICATES_OUTPUT" | awk '{print $1}')
		FILENAME=$(echo "$DUPLICATES_OUTPUT" | awk '{print $2}')
		
		# creating array from md5 output:
		lines_md5=( $MD5_RES )
	        # creating array from file output:
		files_line=( $FILENAME )
	
		CNT=0
		# comparing md5 array to find the differences between duplicated matched files (assigning into groups)
		LAST_DUP=$lines_md5[$CNT]
		MATCHES_CNT=1
		for line in "${lines_md5[@]}"
		do
			if [ ${lines_md5[$CNT]} != $LAST_DUP ]; then
				printf "Match $MATCHES_CNT:\n"
				MATCHES_CNT=$(($MATCHES_CNT + 1))
			fi
			echo "${files_line[$CNT]}"
			LAST_DUP=${lines_md5[$CNT]}
			CNT=$(($CNT + 1))
		done
	fi	
	
	# clearing major vars to avoid future failures
	unset FOLDERPATH
	unset DUPLICATES_OUTPUT
	unset DUPLICATES_CNT
fi
