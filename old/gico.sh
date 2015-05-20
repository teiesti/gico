#!/bin/bash

# Load environment variables
HOME_DIR=$(dirname $(readlink -f $BASH_SOURCE))	# could not be loaded within environment.sh because of chicken and egg
source $HOME_DIR/environment.sh

# Check if a command is given
if [ $# -lt 1 ]; then
	$HOME_DIR/gico-help.sh
	exit
fi

# Execute command
if [ $1 = "configure" ] || [ $1 = "install" ]; then
	if [ $# -eq 1 ]; then
		$HOME_DIR/gico-configure.sh
	else
		$HOME_DIR/gico-help.sh
	fi
elif [ $1 = "clone" ]; then
	if [ $# -eq 2 ]; then
		$HOME_DIR/gico-clone.sh $2
	elif [ $# -eq 3 ]; then
		$HOME_DIR/gico-clone.sh $2 $3
	else
		$HOME_DIR/gico-help.sh
	fi
elif [ $1 = "full-configure" ] || [ $1 = "full-install" ]; then
	if [ $# -eq 1 ]; then
		$HOME_DIR/gico-full-configure.sh
	else
		$HOME_DIR/gico-help.sh
	fi
elif [ $1 = "full-clone" ]; then
	if [ $# -eq 2 ]; then
		$HOME_DIR/gico-full-clone.sh $2
	elif [ $# -eq 3 ]; then
		$HOME_DIR/gico-full-clone.sh $2 $3
	else
		$HOME_DIR/gico-help.sh
	fi
elif [ $1 = "full-update" ] || [ $1 = "full-pull" ]; then
	if [ $# -eq 1 ]; then
		$HOME_DIR/gico-full-update.sh
	else
		$HOME_DIR/gico-help.sh
	fi
elif [ $1 = "init" ]; then
	if [ $# -eq 1 ]; then
		$HOME_DIR/gico-init.sh
	elif [ $# -eq 2]; then
		$HOME_DIR/gico-init.sh $2
	else
		$HOME_DIR/gico-help.sh
	fi	
elif [ $1 = "manage-packages" ]; then
	if [ $# -eq 1 ]; then
		$HOME_DIR/gico-manage-packages.sh
	else
		$HOME_DIR/gico-help.sh
	fi
elif [ $1 = "self-install" ]; then
	if [ $# -eq 1 ]; then
		$HOME_DIR/gico-self-install.sh
	else
		$HOME_DIR/gico-help.sh
	fi
elif [ $1 = "self-update" ]; then
	if [ $# -eq 1 ]; then
		$HOME_DIR/gico-self-update.sh
	else
		$HOME_DIR/gico-help.sh
	fi
elif [ $1 = "smart-configure" ] || [ $1 = "smart-install" ]; then
	if [ $# -eq 1 ]; then
		$HOME_DIR/gico-smart-configure.sh
	else
		$HOME_DIR/gico-help.sh
	fi
elif [ $1 = "smart-clone" ]; then
	if [ $# -eq 2 ]; then
		$HOME_DIR/gico-smart-clone.sh $2
	elif [ $# -eq 3 ]; then
		$HOME_DIR/gico-smart-clone.sh $2 $3
	else
		$HOME_DIR/gico-help.sh
	fi
elif [ $1 = "update" ] || [ $1 = "pull" ]; then
	if [ $# -eq 1 ]; then
		$HOME_DIR/gico-update.sh
	else
		$HOME_DIR/gico-help.sh
	fi
else
	$HOME_DIR/gico-help.sh
fi
