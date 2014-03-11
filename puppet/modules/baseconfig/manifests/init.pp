# == Class: baseconfig
#
# Performs initial configuration tasks for all Vagrant boxes.
#
class baseconfig {

  exec { 'apt-get update':
    command => '/usr/bin/apt-get update'
  }

  exec { 'apt-get update again':
    command => '/usr/bin/apt-get update'
  }

  # Run apt-get update before packages are loaded
  Exec["apt-get update"] -> Package <| |>

  package { 'python-software-properties':
    ensure => present
  }

  exec { 'change PHP repo':
    command => '/usr/bin/apt-add-repository ppa:ondrej/php5-oldstable',
    onlyif => '/usr/bin/test -e /usr/bin/apt-add-repository'
  }

  exec { 'add latest NodeJS repo':
    command => '/usr/bin/apt-add-repository ppa:chris-lea/node.js',
    onlyif => '/usr/bin/test -e /usr/bin/apt-add-repository'
  }

  Package['python-software-properties'] -> Exec['change PHP repo'] -> Exec['add latest NodeJS repo'] ~> Exec['apt-get update again']

  host { 'hostmachine':
    ip => '192.168.0.1'
  }

  file {
    '/home/vagrant/.bashrc':
      owner => 'vagrant',
      group => 'vagrant',
      mode  => '0644',
      source => 'puppet:///modules/baseconfig/bashrc'
  }

  package { 'vim':
      ensure => present
  }
}
