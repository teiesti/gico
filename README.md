# gico
Have You ever had to manage a bunch of Linux servers? Have You tapped Your fingers to the bones when configuring them? Do You have problems with inconsistent configuration files? Or have You lost data when a tricky and labor-intensive file went forever?

Welcome to the **G**it based **I**nstaller and **C**onfiguration **O**rganizer!

The main idea behind *gico* is that You store almost every configuration within a Git repository. Therefore, Your configuration is versionized and can easily be transfered to different servers. Differences in configuration among different servers are managed with branches. If you need to restart a service when the configuration changes, You're able to write a script based hook which is automatically executed whenever You change something.

*gico* is optimized for Debian 8 "Jessie" but - with some keystrokes - it will make it on different operation systems (expect Windows and Co.), too.
