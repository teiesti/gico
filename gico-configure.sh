#!/bin/bash

# Load environment variables
HOME_DIR=$(dirname $(readlink -f $BASH_SOURCE))	# could not be loaded within environment.sh because of chicken and egg
source $HOME_DIR/environment.sh

# TODO We may need to check access rights here. For instance we need to be root. A possible check would be...
## Check if I am root, abort if not.
#if [ $(whoami) != "root" ]; then
#	>&2 echo "Error! I am not root."
#	exit
#fi

# Rewrite backup path, if path already exists
if [ -e $BACKUP_DIR ]; then
	N=1
	while [ -e $BACKUP_DIR"_"$N]
	do
		N=$N+1
	done
	BACKUP_DIR=$BACKUP_DIR"_"$N
fi

# Install new resources files and back up existing ones
echo "Installing new resources files. Existing files will be backed up to $BACKUP_DIR."
for RESOURCE_FILE in $(find $RESOURCE_DIR -type f); do
	EXISTING_FILE=${RESOURCE_FILE#$RESOURCE_DIR}
	BACKUP_FILE=$BACKUP_DIR/$EXISTING_FILE
	
	# Ignore git related files like .gitignore or .gitkeep
	if [[ $RESOURCE_FILE =~ \.git* ]]; then
		echo "Ignoring git related file $RESOURCE_FILE."
		continue
	fi
	
	# Ignore files that are already installed
	if [ $RESOURCE_FILE -ef $EXISTING_FILE ]; then
		echo "Ignoring already installed file $RESOURCE_FILE."
		continue
	fi
	
	# Move existing files to the backup folder or create a dummy file if no such file exists
	mkdir -p $(dirname $BACKUP_FILE)
	if [ -e $EXISTING_FILE ]; then
		echo "Moving $EXISTING_FILE to the backup folder."
		mv $EXISTING_FILE $BACKUP_FILE
	else
		echo "Warning! There is no file named $EXISTING_FILE. Writing empty dummy file to the backup folder."
		echo > $BACKUP_FILE
	fi
	
	# Install resource file (using a hardlink, because symlinks have problems with permissions)
	echo "Installing $RESOURCE_FILE to $EXISTING_FILE."
	ln $RESOURCE_FILE $EXISTING_FILE
done

# Execute hooks (e.g. to restart services)
echo "Executing hooks."
for HOOK_FILE in $(find $HOOK_DIR -type f); do
	# Ignore git related files like .gitignore or .gitkeep
	if [[ $HOOK_FILE =~ \.git* ]]; then
		echo "Ignoring git related file $RESOURCE_FILE."
		continue
	fi
	
	# Execute hook file if executable
	if [ -x $HOOK_FILE ]; then
		echo "Executing $HOOK_FILE."
		$HOOK_FILE
	else
		>&2 echo "Error! $HOOK_FILE is not executable."
	fi
done
