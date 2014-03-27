vagrant-lampn
=============

Creates a basic LAMP + NodeJS stack with Vagrant and Puppet.

This doesn't use Puppet Librarian, Hiera or various Puppet modules at all so that it is easy to read and modify even for those who are not Puppet virtuosos.

You can configure basic virtual machine parameters from Vagrantfile. Everything else is in Puppet scripts in the "puppet" folder and they're laid out like this:

* puppet
    * manifests
        * site.pp - Main script
    * modules/{modulename}
        * manifests
            * init.pp - The module script
        * files
            * Files installed by the module

At the moment the modules are:
* apache     - Installs Apache 2, check the "webapp" vhost file if you need to make changes to server config
* baseconfig - Basic configuration for modules and environment
* mysql      - Installs a MySQL server, remember to change the username and password to your liking here
* nodejs     - Installs NodeJS
* php        - Installs PHP 5.4.x
* helpers    - Helper resource types for Puppet scripts
* extras     - Extra packages etc to load. By default installs Vim, Git, Curl and Composer.

About Vagrant config options:

* hostname must be unique, it is also used as the virtual machine name
* ip allowed values are "your.ip.address", "dchp" or false. False uses Vagrant's public networking setting.
* forwarded_port allowed values are port number and false to not use port forwarding
* synced_folders must always be an array, e.g. ["my/first/folder", "/my/second/folder"]. Use ["."] to use same folder as Vagrant config

Connecting to MySQL using Sequel Pro (Mac) or HeidiSQL (Windows):

* Hostname: 127.0.0.1
* User: root (or whatever you set as MySQL password)
* Password: root
* Port: 3306 (or default)
* SSH host: your.VM.IP.address (run vagrant ssh and ifconfig to find it)
* SSH port: 22
* SSH user: vagrant
* SSH password: vagrant
* SSH local port: 3307 (or default)

Note that HeidiSQL is a bit crap so you may have to run this first in Command Prompt and answer yes to store the SSH key:

plink.exe -ssh vagrant@your.VM.IP.address -pw "vagrant" -P 22 -N -L 3307:127.0.0.1:3306

After this you should be able to connect.