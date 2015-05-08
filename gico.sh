#!/bin/bash

# Check if a command is given
if [ $# -lt 1 ] ]; then
	./gico-help.sh
	exit
fi

# Execute command
if [ $1 -eq "configure"]; then
	if [ $# -eq 1 ]; then
		./gico-configure.sh
	else
		./gico-help.sh
	fi
elif [ $1 -eq "configure-packages"]; then
	if [ $# -eq 1 ]; then
		./gico-configure-packages.sh
	else
		./gico-help.sh
	fi
fi
elif [ $1 -eq "full-install"]; then
	if [ $# -eq 2 ]; then
		./gico-full-install.sh $2
	elif [ $# -eq 3 ]; then
		./gico-full-install.sh $2 $3
	else
		./gico-help.sh
	fi
fi
elif [ $1 -eq "full-update"]; then
	if [ $# -eq 1 ]; then
		./gico-full-update.sh
	else
		./gico-help.sh
	fi
fi
elif [ $1 -eq "install"]; then
	if [ $# -eq 2 ]; then
		./gico-install.sh $2
	elif [ $# -eq 3 ]; then
		./gico-install.sh $2 $3
	else
		./gico-help.sh
	fi
fi
elif [ $1 -eq "update"]; then
	if [ $# -eq 1 ]; then
		./gico-update.sh
	else
		./gico-help.sh
	fi
else
	./gico-help.sh
fi
