#!/bin/bash

# Load environment variables
HOME=$(dirname $(readlink -f $BASH_SOURCE))	# could not be loaded within environment.sh because of chicken and egg
source $HOME/environment.sh

# Update the gico repository
git -C $HOME pull
