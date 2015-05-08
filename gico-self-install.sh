#!/bin/bash

# Load environment variables
HOME_DIR=$(dirname $BASH_SOURCE)	# could not be loaded within environment.sh because of chicken and egg
source $HOME_DIR/environment.sh

# Install myself to the system
ln -s $HOME_DIR/gico.sh $BIN_DIR/gico
