# == Class: nodejs
#
# Installs NodeJS and Grunt CLI
#
class nodejs {

  package { 'nodejs':
    require => Exec['add latest NodeJS repo']
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
    require => Package['nodejs'];
  }

  exec { 'install Grunt modules':
    cwd => '/vagrant',
    command => '/usr/bin/npm install',
    onlyif => '/usr/bin/test -e /vagrant/package.json',
    returns => 255
  }

}
