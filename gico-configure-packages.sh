#!/bin/bash

# Load environment variables
HOME_DIR=$(dirname $(readlink -f $BASH_SOURCE))	# could not be loaded within environment.sh because of chicken and egg
source $HOME_DIR/environment.sh

# Install or uninstall packages
echo "Configuring packages as defined in $PACKAGES_FILE."
for QUALIFIED_PACKAGE in $(cat $PACKAGES_FILE); do
	JOB=${QUALIFIED_PACKAGE:0:1}
	PACKAGE=${QUALIFIED_PACKAGE:1}

	if [ $JOB = "+" ]; then
		echo "Installing $PACKAGE."
		apt-get -y install $PACKAGE
	elif [ $JOB = "-" ]; then
		echo "Removing $PACKAGE."
		apt-get -y remove $PACKAGE
	elif [ $JOB = "_" ]; then
		echo "Purging $PACKAGE."
		apt-get -y purge $PACKAGE
	else
		PACKAGE=$QUALIFIED_PACKAGE
		echo "Installing $PACKAGE."
		apt-get -y install $PACKAGE
	fi
done
