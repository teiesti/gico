#!/bin/bash

# Load environment variables
HOME=$(dirname $(readlink -f $BASH_SOURCE))	# could not be loaded within environment.sh because of chicken and egg
source $HOME/environment.sh

# Check if Git is installed
if [ ! -x $(which git) ]; then
	>&2 echo "Error! Git is not installed."
	exit
fi

# Check if the directory for the configuration repository is empty
if [ -e $REPO ] && [ "$(ls -A $REPO)" ]; then
	>&2 echo "Error! '$REPO' is not empty."
	exit
fi

# Clone repository
echo "Cloning repository."
if [ $# -eq 1 ]; then
	git clone $1 $REPO
elif [ $# -eq 2 ]; then
	git clone -b $2 $1 $REPO
else
	# This should never happen because such errors are caught by gico.sh
	>&2 echo "Error! Wrong number of arguments."
fi

# Configure resources
$HOME/gico-configure.sh
