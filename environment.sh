#!/bin/bash

BIN_DIR=/usr/local/bin					# path to the bin folder
DIR=/usr/local/etc/gico					# path to the configuration repository
RESOURCE_DIR=$DIR/res					# path where installable resources where stored
BACKUP_DIR=$DIR/backup					# path where existing but deprecated resources with the same name were backed up
HOOK_DIR=$DIR/hooks						# path where executable hooks where stored
PACKAGES_FILE=$DIR/packages				# file that know whichs packages needed to be installed or uninstalled
REPO_VERSION="v1.0.0-rc1"				# version of the configuration repository
REPO_EMPTY_URL="https://github.com/teiesti/gico-empty-repository"	# url where an empty configuration repository can be found
BASED_ON_FILE=$DIR/based-on				# file that stores where the installation is based on
