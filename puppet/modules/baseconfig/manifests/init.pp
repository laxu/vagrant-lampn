# == Class: baseconfig
#
# Performs initial configuration tasks for all Vagrant boxes.
#
class baseconfig {

  exec { 'apt-get update':
    command => '/usr/bin/apt-get update'
  }

  # Run apt-get update before packages are loaded
  Exec["apt-get update"] -> Package <| |>

  package { 'python-software-properties':
    ensure => present
  }

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

}
