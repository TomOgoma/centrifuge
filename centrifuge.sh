#! /bin/bash

#####################################################
#													#
#													#
#		   	  GNU GENERAL PUBLIC LICENSE			#
#                Version 2, June 1991				#
#													#
#													#
#####################################################

# Centrifuge - separates files in folders based on
# provided file name pattern.

# @author Tom Ogoma
# https://github.com/tomogoma
# ogomatom@gmail.com


# separate separates files from source folder
# into destination folder based on the file
# name pattern provided.
# $1 source folder
# $2 destination folder
# $3 file name pattern
function separate {

	for entry in "$1"/*
	do
		if [[ $entry =~ .*"$3".* ]] && [[ -f $entry ]]
			then
			mv "$entry" "$2"
		fi
	done
}

# usage prints out the help message for this application.
# $1 the name of the program.
# $2 [optional] an error message to print.
function usage {

	if [[ -n $2 ]]; then
		echo "$2"
	fi
	echo "Usage: $1 [src-folder] [dest-folder] [file-name-pattern]"
}

# check goes through provided parameters to determine whether they are valid.
# $1 the program name (corresponds to $0 at entry level parameters)
# $2 the source folder (corresponds to $1 at entry level parameters)
# $3 the destination folder (corresponds to $2 at entry level parameters)
# $4 the file name matching pattern (corresponds to $3 at entry level parameters)
function check {

	if [ -z $2 ]
		then
		usage $1
		exit -1
	fi

	if [ -z $3 ]
		then
		usage $1
		exit -1
	fi

	if [ -f $3 ]
		then
		usage $1 "dest-folder cannot be a regular file."
		exit -1
	fi

	if [ -z $4 ]
		then
		usage $1 "No pattern provided, will match all file-name patterns"
	fi
}

# prep prepares any pre-requisites for the app to run correctly
# e.g. it creates the destination directory if not exist.
# $1 the destinaton directory
function prep {

	if [ ! -d $1 ]
		then
		mkdir $1
	fi
}

## Start main bash script ##

check $0 $1 $2 $3
prep $2
separate $1 $2 $3