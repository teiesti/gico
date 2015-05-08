#!/bin/bash

# Load environment variables
HOME_DIR=$(dirname $(readlink -f $BASH_SOURCE))	# could not be loaded within environment.sh because of chicken and egg
source $HOME_DIR/environment.sh

# Install or uninstall packages
echo "Configuring packages as defined in $PACKAGES_FILE."
for QUALIFIED_PACKAGE in $(cat $PACKAGES_FILE); do
	JOB=$(QUALIFIED_PACKAGE:0:1)
	PACKAGE=$(QUALIFIED_PACKAGE:1)
	
	if [ $JOB -eq "+" ]; then
		echo "Installing $PACKAGE."
		apt-get -y install $PACKAGE
	elif [ $JOB -eq "-" ]; then
		echo "Removing $PACKAGE."
		apt-get remove $PACKAGE
	elif [ $JOB -eq "_" ]; then
		echo "Purging $PACKAGE."
		apt-get purge $PACKAGE
	else
		$PACKAGE=$QUALIFIED_PACKAGE
		echo "Installing $PACKAGE."
		apt-get install $PACKAGE
	fi	
done
