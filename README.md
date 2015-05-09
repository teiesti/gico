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
In most cases, You want to clone an existing repository from a server. You can do this with `gico install <repo> [<branch>]` where `<repo>` is the URL to a usual Git repository. To avoid errors, it should have the structure explained above. You can use the optional `<branch>` parameter to clone a specific branch. This is especially useful if You have to manage different servers with slightly different configuration. Cloning an repository will install any file in `<repo>/res` to the root of Your file system using hardlinks. Hardlinks are used because they do better with permissions and won't break if someone removes the original - otherwise this may breaks the hole system. `gico install <repo> [<branch>]` does not install or remove the packages specified in `<repo>/packages`. Therefore, please use `gico full-install <repo> [<branch>]`.

### Adding configuration and changing it
If You want to manage a configuration file with *gico*, simply add it to the `<repo>/res` folder. You can use any Git procedure You're familiar with. Then call `gico configure` and see how Your file is installed to the root directioy of Your system. E.g. if Your file lives in `<repo>/res/etc/`, a hardlink will appear in `/etc/`. Any existing file will be moved to `<repo>/backup`. If there is no file, an empty dummy file will be added to the backup folder. *Attention:* If you're deleting a file, the hardlink will not disapper automatically. You need to do this by hand. After `gico configure` has installed the resource files, all hooks in `<repo>/hooks` will be executed in alphabetical order. `gico configure` will not install or remove package which are configured in `<repo>/packages`. 

### Updating configuration from a remote
Let's assume, Your configuration repository has a remote on a server or somewhere else (e.g. because You cloned it). Let's also assume, Your "remote configuration" was changed. You can pull the remote configuration with `gico update` which is a shorthand for something like `git -C <repo> pull` and `git configure`. The command will
  - update any outdated configuration file,
  - load new ones and
  - create new hardlinks for new configuration files like 'gico configure' does.
*Attention*:  Hardlinks for deleted files will not disappear automatically due to a certain reason. The system can't know if Your deleting a configuration file because it is not longer needed or if You just want to delete it from the version control system. Therefore, you may need to clean up Your system by hand.
`git update` does not install or remove packages as specified in Your packages file. Therefore, please use `gico full-update`.

### Installing and removing packages
*gico* allows You to automatically install or remove packages. The first thing You need to understand about this feature is that *gico* always regards the current state of Your machine: *gico* does nothing if nothing is specified in `<repo>/packages`. Based on that you can add a packages by adding `+<package name>` or `<package name>` as a new row to the configuration file. To delete a package add `-<package name>`. To purge a package use `_<package name>`. Please note, that required dependencies will be installed. On the other hand, if a deletion causes a (automatically installed) dependency to be unused, that dependency will be deleted. *gico* honors the appearance order in `<repo>/packages`.

The second thing You need to know about managing packages via *gico* is that most commands simply don't regard it. This is a tribute to the fact that installing or removing packages can cause massive problems including loss of data. If You just want to apply what's written in `<repo>/packages` call `gico manage-packages`. If you want that a certain command like `gico <cmd> [<parameter> ...]` regards the package management call `gico full-<cmd> [<parameter> ...]` instead. This is possible for most commands.

## Advanced maneuvers

### Writing installers with different branches
TODO

## Updating *gico*
TODO

## Contribute code to *gico*
TODO

## Frequently asked questions
TODO
