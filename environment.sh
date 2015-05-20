#!/bin/bash

BIN=/usr/local/bin								# path to the bin folder

REPO=/usr/local/etc/gico						# path to the configuration repository
REPO_VERSION="v2.0.0-1"							# version of the configuration repository
REPO_EMPTY_URL="https://github.com/teiesti/gico-empty-repository"	# url where an empty configuration repository can be found

# Note: The following enviroment variables need to be initialized with the current subfolder.
# Do this with 'init_env <subfolder>
function init_env {
	BACKUP_DIR=$REPO/$1/backup/$(date +%F_%T)	# path where existing but deprecated resources with the same name were backed up	
	HOOK_DIR=$REPO/$1/hooks						# path where executable hooks where stored
	RESOURCE_DIR=$REPO/$1/res					# path where installable resources where stored
	PACKAGES_FILE=$REPO/$1/packages				# file that knows whichs packages needed to be installed or uninstalled
}
