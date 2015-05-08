#!/bin/bash

# Load environment variables
source environment.sh

# TODO We may need to check access rights here. For instance we need to be root. A possible check would be...
## Check if I am root, abort if not.
#if [ $(whoami) != "root" ]; then
#	>&2 echo "Error! I am not root."
#	exit
#fi

# Install new resources files and back up existing ones
echo "Installing new resources files. Existing files will be backed up to $BACKUP_DIR."
for RESOURCE_FILE in $(find $RESOURCE_DIR -type f); do
	EXISTING_FILE=${RESOURCE_FILE#$RESOURCE_DIR}
	BACKUP_FILE=$BACKUP_DIR$ORIGINAL_FILE
	
	# Check if the resource file is already installed
	if [ ! $RESOURCE_FILE -ef $EXISTING_FILEE ]; then
		mkdir -p $(dirname $BACKUP_FILE)
		
		# Move existing files to the backup folder or create a dummy file if no such file exists
		if [ -e $EXISTING_FILE ]; then
			echo "Moving $EXISTING_FILE to the backup folder."
			mv $EXISTING_FILE $BACKUP_FILE
		else
			echo "Warning! There is no file named $EXISTING_FILE. Creating empty dummy file within the backup folder."
			echo > $BACKUP_FILE
		fi
	
		# Install resource file (using a hardlink, because symlinks have problems with permissions)
		echo "Installing $RESOURCE_FILE to $EXISTING_FILE."
		ln $RESOURCE_FILE $EXISTING_FILE
	fi
done

# Execute hooks (e.g. to restart services)
echo "Executing hooks."
for HOOK_FILE in $(find $HOOK_DIR -type f); do
	if [ -x $HOOK_FILE ]; then
		echo "Executing $HOOK_FILE."
		$HOOK_FILE
	else
		>&2 echo "Error! $HOOK_FILE is not executable."
	fi
done
