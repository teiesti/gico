#!/bin/bash

echo "usage: gico <command> [<arguments>]

The gico commands are:
   clone             Clone a gico repository and execute 'configure'
   configure         Install resources to the system and execute hooks
   full-clone        Shorthand for 'clone' and 'manage-packages'
   full-configure    Shorthand for 'configure' and 'manage-packages'
   full-update       Shorthand for 'update' and 'manage-packages'
   help              Show this help
   init              Create an empty gico repository
   manage-packages   Install, remove and purge packages
   self-install      Install the 'gico' command to the system
   self-update       Update the 'gico' command to the latest version
   smart-configure   Recursively checkout the reference in 'based-on' and
                     execute 'full-configure' on the way back up.
   smart-clone       Clone a gico repository and execute 'smart-configure'
   update            Update a gico repository and execute 'configure'
   
For detailed information read the official README file."