#!/bin/bash

HOME_DIR=$(dirname $(readlink -f ${0}))	# path where all the gico scripts live
BIN_DIR=/usr/local/bin					# path to the bin folder
DIR=/usr/local/etc/gico					# path to the configuration repository
RESOURCE_DIR=$DIR/res					# path where installable resources where stored
BACKUP_DIR=$DIR/backup					# path where existing but deprecated resources with the same name were backed up
HOOK_DIR=$DIR/hooks						# path where executable hooks where stored
PACKAGES_FILE=$DIR/packages				# file that know whichs packages needed to be installed or uninstalled
