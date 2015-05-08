#!/bin/bash

# Check if a command is given
if [ $# -lt 1 ]; then
	./gico-help.sh
	exit
fi

# Execute command
if [ $1 = "configure" ]; then
	if [ $# -eq 1 ]; then
		./gico-configure.sh
	else
		./gico-help.sh
	fi
elif [ $1 = "configure-packages" ]; then
	if [ $# -eq 1 ]; then
		./gico-configure-packages.sh
	else
		./gico-help.sh
	fi
elif [ $1 = "full-install" ]; then
	if [ $# -eq 2 ]; then
		./gico-full-install.sh $2
	elif [ $# -eq 3 ]; then
		./gico-full-install.sh $2 $3
	else
		./gico-help.sh
	fi
elif [ $1 = "full-update" ]; then
	if [ $# -eq 1 ]; then
		./gico-full-update.sh
	else
		./gico-help.sh
	fi
elif [ $1 = "install" ]; then
	if [ $# -eq 2 ]; then
		./gico-install.sh $2
	elif [ $# -eq 3 ]; then
		./gico-install.sh $2 $3
	else
		./gico-help.sh
	fi
elif [ $1 = "self-install" ]; then
	if [ $# -eq 1 ]; then
		./gico-self-install.sh
	else
		./gico-help.sh
	fi
elif [ $1 = "update" ]; then
	if [ $# -eq 1 ]; then
		./gico-update.sh
	else
		./gico-help.sh
	fi
else
	./gico-help.sh
fi
