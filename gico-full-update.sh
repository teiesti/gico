#!/bin/bash

# Load environment variables
HOME_DIR=$(dirname $BASH_SOURCE)	# could not be loaded within environment.sh because of chicken and egg
#source $HOME_DIR/environment.sh

$HOME_DIR/gico-update.sh
$HOME_DIR/gico-configure-packages.sh