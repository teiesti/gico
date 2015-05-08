#!/bin/bash

DIR=/usr/local/etc/gico			# path to the configuration repository
RESOURCE_DIR=$DIR/res			# path where installable resources where stored
BACKUP_DIR=$DIR/backup			# path where existing but deprecated resources with the same name were backed up
HOOK_DIR=$DIR/hooks				# path where executable hooks where stored
PACKAGES_FILE=$DIR/packages		# file that know whichs packages needed to be installed or uninstalled
