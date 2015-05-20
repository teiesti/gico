#!/bin/bash

HOME=/usr/local/bin						# path to the bin folder

REPO=/usr/local/etc/gico				# path to the configuration repository
REPO_VERSION="v2.0.0-1"					# version of the configuration repository
REPO_EMPTY_URL="https://github.com/teiesti/gico-empty-repository"	# url where an empty configuration repository can be found

# Note:	The following paths are relative to the service subfolder. 
# A good syntax to use them is '$REPO/<service_subfolder>/<relative_path>', e.g. '$REPO/00-example/$HOOK'.
BACKUP=backup/$(date +%F_%T)			# path where existing but deprecated resources with the same name were backed up	
HOOK=hooks								# path where executable hooks where stored
RESOURCE=res							# path where installable resources where stored
PACKAGES=packages						# file that knows whichs packages needed to be installed or uninstalled
