#!/bin/bash

# TODO At the moment, this code is almost a 1-to-1 copy of gico-clone.sh. Someone may correct this.

# Load environment variables
HOME_DIR=$(dirname $(readlink -f $BASH_SOURCE))	# could not be loaded within environment.sh because of chicken and egg
source $HOME_DIR/environment.sh

# Check if Git is installed
if [ ! -x $(which git) ]; then
	>&2 echo "Error! Git is not installed."
	exit
fi

# Check if the directory for the configuration repository is empty
if [ -e $DIR ] && [ "$(ls -A $DIR)" ]; then
	>&2 echo "Error! $DIR is not empty."
	exit
fi

# Clone repository
echo "Cloning repository."
if [ $# -eq 1 ]; then
	git clone $1 $DIR
elif [ $# -eq 2 ]; then
	git clone -b $2 $1 $DIR
else
	# This should never happen because such errors are caught by gico.sh
	>&2 echo "Error! Wrong number of arguments."
fi

# Configure resources
$HOME_DIR/gico-smart-configure.sh
