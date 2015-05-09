#!/bin/bash

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

# Creating a new gico repository
echo "Creating repository."

if [ $# -eq 0 ]; then
	git clone -b $REPO_VERSION --depth 1 $REPO_EMPTY_URL $DIR
elif [ $# -eq 1 ]; then
	git clone -b $1 --depth 1 $REPO_EMPTY_URL $DIR
else
	# This should never happen because such errors are caught by gico.sh
	>&2 echo "Error! Wrong number of arguments."
fi

git checkout -b $(hostname)
git remote rm origin