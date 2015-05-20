#!/bin/bash

# Load environment variables
HOME_DIR=$(dirname $(readlink -f $BASH_SOURCE))	# could not be loaded within environment.sh because of chicken and egg
source $HOME_DIR/environment.sh

# Check if repository is clean, abort if not
if [ ! -z $(git -C $DIR status --porcelain) ]; then
	>&2 echo "Error! Gico repository $DIR is not clean."
	exit
fi

# If the based-on file exists and is not empty, we need to configure the "based-on" configuration first
if [ -s $BASED_ON_FILE ]; then
	# Read based-on file and check its syntax
	BASED_ON=$(head -n 1 $BASED_ON_FILE)
	git -C $DIR check-ref-format --branch $BASED_ON > /dev/null
	if [ $? -ne 0 ]; then
		>&2 echo "Error! $BASED_ON_FILE contains no valid reference to a branch, tag or commit."
		exit
	fi

	# Save reference to the current HEAD, use branch or tag name if available 
	CURRENT_COMMIT=$(git -C $DIR rev-parse --abbrev-ref HEAD)
	if [ $CURRENT_COMMIT = "HEAD" ]; then
		CURRENT_COMMIT=$(git -C $DIR rev-parse HEAD)
	fi
	
	# Checkout the branch, tag or commit this configuration is based on
	echo "The current configuration is based on $BASED_ON. Checking it out."
	git -C $DIR checkout $BASED_ON

	# Configure the configuration this configuration is based on (this works recursivly)
	$HOME_DIR/gico-smart-configure.sh $@
	
	# Restore the configuration we came from
	echo "Restoring the configuration we came from. This is $CURRENT_COMMIT."
	git -C $DIR checkout $CURRENT_COMMIT
else
	echo "The current configuration is not based on another one. We can simply configure it."
fi

# Fully-configure the current configuration
$HOME_DIR/gico-full-configure.sh $@
