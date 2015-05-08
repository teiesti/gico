#!/bin/bash

# Load environment variables
source environment.sh

# Check if Git is installed
if [ ! -x $(which git) ]; then
	>&2 echo "Error! Git is not installed."
	exit
fi

# Update repository
echo "Updating repository."
git -C $DIR pull

# Update links within the file system
./gico-configure.sh