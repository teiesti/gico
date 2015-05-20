#!/bin/bash

# Load environment variables
HOME=$(dirname $(readlink -f $BASH_SOURCE))	# could not be loaded within environment.sh because of chicken and egg
source $HOME/environment.sh

# Check if a command is given
if [ $# -lt 1 ]; then
	$HOME/gico-help.sh
	exit
fi

# Execute command
if [ $1 = "clone" ]; then
	if [ $# -eq 2 ]; then
		$HOME/gico-clone.sh $2
	elif [ $# -eq 3 ]; then
		$HOME/gico-clone.sh $2 $3
	else
		$HOME/gico-help.sh
	fi
elif [ $1 = "init" ]; then
	if [ $# -eq 1 ]; then
		$HOME/gico-init.sh
	elif [ $# -eq 2]; then
		$HOME/gico-init.sh $2
	else
		$HOME/gico-help.sh
	fi	
elif [ $1 = "install" ] || [ $1 = "configure" ]; then
	if [ $# -eq 1 ]; then
		$HOME/gico-install.sh
	else
		$HOME/gico-help.sh
	fi
elif [ $1 = "pull" ] || [ $1 = "update" ]; then
	if [ $# -eq 1 ]; then
		$HOME/gico-pull.sh
	else
		$HOME/gico-help.sh
	fi
elif [ $1 = "self-install" ]; then
	if [ $# -eq 1 ]; then
		$HOME/gico-self-install.sh
	else
		$HOME/gico-help.sh
	fi
elif [ $1 = "self-update" ]; then
	if [ $# -eq 1 ]; then
		$HOME/gico-self-update.sh
	else
		$HOME/gico-help.sh
	fi
else
	$HOME/gico-help.sh
fi
