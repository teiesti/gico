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

### Cloneing an existing repository
In most cases, You want to clone an existing repository from a server. You can to this with `gico install <repo> [<branch>]` where `<repo>` is the URL to a usual Git repository. To avoid errors, it should have the structure explained above. You can use the optional `<branch>` branch parameter to clone a specific branch. This is especially useful if You have to manage different servers with slightly different configuration. Cloning an repository will install any file in `<repo>/res` to the root of Your file system using hardlinks. Hardlinks are used because they do better with permissions and won't break if someone removes the original - otherwise this may breaks the hole system. `gico install <repo> [<branch>]` does not install or remove the packages specified in `<repo>/packages`. Therefore, please use `gico full-install <repo> [<branch>]`.
