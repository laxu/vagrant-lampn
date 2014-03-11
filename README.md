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
* apache - Installs Apache 2
* baseconfig - Basic configuration for modules and environment
* mysql - Installs a MySQL server, remember to change the username and password to your liking here
* nodejs - Installs NodeJS
* php - Installs PHP 5.4.x