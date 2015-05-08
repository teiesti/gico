# gico
Have You ever had to manage a bunch of Linux servers? Have You tapped Your fingers to the bones when configuring them? Do You have problems with inconsistent configuration files? Or have You lost data when a tricky and labor-intensive file went forever?

Welcome to the **G**it based **I**nstaller and **C**onfiguration **O**rganizer!

The main idea behind *gico* is that You store almost every configuration within a Git repository. Therefore, Your configuration is versionized and can easily be transfered to different servers. Differences in configuration among different servers are managed with branches. If you need to restart a service when the configuration changes, You're able to write a script based hook which is automatically executed whenever You change something.

*gico* is optimized for Debian 8 "Jessie" but - with some keystrokes - it will make it on different operation systems (expect Windows and Co.), too.

## Installation
  * Navigate to the folder, you want to install *gico* to: `cd /usr/local/src`.
  * Clone this repository at the current stable version: `git clone -b stable https://github.com/teiesti/gico`.
  * Install the `gico` command to Your system: `gico/gico.sh self-install`. This creates a symlink from `/usr/local/bin` to `<repo>/gico.sh`.

## Basic operations

### Creating a repository (not yet implemented)
To use *gico* You need to create a new "gico-flavored" Git repository. The easiest way to do this, is to run `gico init [<branch>]`. This creates an "empty" repository to `/usr/local/etc/gico`. If this path already exists, *gico* will abort and You must manually delete the folder. An empty repository consists of
  - `<repo>/res` where all the installable resource files (e.g. configuration files) live,
  - `<repo>/hooks' which stores the hooks,
  - `<repo>/backup` which is used to back up existing files when the resources are installed and 
  - `<repo>/packages`which is a list of packages which should be installed or removed.
