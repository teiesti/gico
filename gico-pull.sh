#!/bin/bash

# Load environment variables
HOME=$(dirname $(readlink -f $BASH_SOURCE))	# could not be loaded within environment.sh because of chicken and egg
source $HOME/environment.sh

# Check if Git is installed
if [ ! -x $(which git) ]; then
	>&2 echo "Error! Git is not installed."
	exit
fi

# Check if remote repository is specified
if [ -z $(git -C $REPO remote) ]; then
	>&2 echo "Error! No remote repository is specified."
	exit
fi

# Update repository
echo "Updating repository."
git -C $REPO pull

# Update links within the file system
$HOME/gico-install.sh