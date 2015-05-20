#!/bin/bash

# Load environment variables
HOME=$(dirname $(readlink -f $BASH_SOURCE))	# could not be loaded within environment.sh because of chicken and egg
source $HOME/environment.sh

# Install configuration from any subfolder
for DIR in $REPO/*/; do
	echo "Installing configuration in '$DIR'."
	init_env $DIR
	
	# Install or uninstall packages
	echo "Managing packages as defined in '$PACKAGES_FILE.'"
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
	
	# Rewrite backup path, if path already exists
	if [ -e $BACKUP_DIR ]; then
		N=1
		while [ -e $BACKUP_DIR"_"$N]
		do
			N=$N+1
		done
		BACKUP=$BACKUP_DIR"_"$N
	fi
	
	# Install new resources files and back up existing ones
	echo "Installing new resources files."
	echo "Existing files will be backed up to '$BACKUP_DIR'."
	for RESOURCE_FILE in $(find $RESOURCE -type f); do
		EXISTING_FILE=${RESOURCE_FILE#$RESOURCE}
		BACKUP_FILE=$BACKUP_DIR/$EXISTING_FILE
		
		# Ignore git related files like .gitignore or .gitkeep
		if [[ $RESOURCE_FILE =~ \.git* ]]; then
			echo "Ignoring git related file '$RESOURCE_FILE'."
			continue
		fi
		
		# Ignore files that are already installed
		if [ $RESOURCE_FILE -ef $EXISTING_FILE ]; then
			echo "Ignoring installed file '$RESOURCE_FILE'."
			continue
		fi
		
		# Move existing files to the backup folder or create a dummy file if no such file exists
		mkdir -p $(dirname $BACKUP_FILE)
		if [ -e $EXISTING_FILE ]; then
			echo "Moving '$EXISTING_FILE' to the backup folder."
			mv $EXISTING_FILE $BACKUP_FILE
		else
			echo "Warning! There is no file named '$EXISTING_FILE'. Writing empty dummy file to the backup folder."
			echo > $BACKUP_FILE
		fi
		
		# Install resource file (using a hardlink, because symlinks have problems with permissions)
		echo "Installing '$RESOURCE_FILE' to '$EXISTING_FILE'."
		ln $RESOURCE_FILE $EXISTING_FILE
	done
	
	# Execute hooks (e.g. to restart services)
	echo "Executing hooks."
	for HOOK_FILE in $(find $HOOK -type f); do
		# Ignore git related files like .gitignore or .gitkeep
		if [[ $HOOK_FILE =~ \.git* ]]; then
			echo "Ignoring git related file '$RESOURCE_FILE'."
			continue
		fi
		
		# Execute hook file if executable
		if [ -x $HOOK_FILE ]; then
			echo "Executing '$HOOK_FILE'."
			$HOOK_FILE
		else
			>&2 echo "Error! '$HOOK_FILE' is not executable."
		fi
	done

done
