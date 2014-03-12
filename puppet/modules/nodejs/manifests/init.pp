# == Class: nodejs
#
# Installs NodeJS and Grunt CLI
#
class nodejs {

  helpers::addrepo {'NodeJS':
    repo => 'ppa:chris-lea/node.js'
  }

  package { 'nodejs':
    require => Helpers::Addrepo['NodeJS']
  }

  # Install npm-check-updates
  package { 'npm-check-updates':
    ensure   => present,
    provider => 'npm',
    require => Package['nodejs']
  }

  # Install Grunt commandline interface
  package { 'grunt-cli':
    ensure   => present,
    provider => 'npm',
    require => Package['nodejs']
  }

  # Install package.json that installs some Grunt modules
  file {
    '/vagrant':
      ensure => directory,
      before => File ['/vagrant/package.json'];

    '/vagrant/package.json':
      source  => 'puppet:///modules/nodejs/package.json',
      ensure => present,
      replace => 'no',
      require => Package['nodejs'];
  }

  # Install the Grunt modules, unless node_modules directory exists already
  exec { 'install Grunt modules':
    cwd => '/vagrant',
    command => '/usr/bin/npm install --no-bin-links',
    unless => '/usr/bin/test -d /vagrant/node_modules',
    require => Package['nodejs'],
    returns => 255
  }

}
