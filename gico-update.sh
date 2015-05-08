#!/bin/bash

# Load environment variables
source environment.sh

# Update repository
echo "Updating repository."
if [ ! -x $(which git) ]; then
	>&2 echo "Error! Git is not installed."
	exit
fi
git -C $DIR pull

# Update links within the file system
./gico-configure.sh