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

# Creating a new gico repository
echo "Creating repository."

echo "Cloning '$REPO_EMPTY_URL' to '$REPO'."
git clone -b $REPO_VERSION --no-checkout --depth 1 $REPO_EMPTY_URL $REPO

if [ $# -eq 0 ]; then
	git -C $REPO checkout -b $(hostname)
elif [ $# -eq 1 ]; then
	git -C $REPO checkout -b $1
else
	# This should never happen because such errors are caught by gico.sh
	>&2 echo "Error! Wrong number of arguments."
fi

echo "Rewriting commit message."
git -C $REPO commit -q --amend -m "Basic repository structure for gico added."

echo "Removing remote origin."
git -C $REPO remote rm origin