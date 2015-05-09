#!/bin/bash

# Load environment variables
HOME_DIR=$(dirname $(readlink -f $BASH_SOURCE))	# could not be loaded within environment.sh because of chicken and egg
#source $HOME_DIR/environment.sh

$HOME_DIR/gico-configure.sh $@
$HOME_DIR/gico-manage-packages.sh