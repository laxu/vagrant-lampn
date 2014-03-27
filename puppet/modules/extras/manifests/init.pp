# == Class: extras
#
# Loads additional packages
#
class extras {

  package { 'vim':
    ensure => present
  }

  package { 'git':
    ensure => present
  }

  package { 'curl':
    ensure => present
  }

  exec { 'install Composer':
    cwd => '/vagrant',
    command => '/usr/bin/curl -s https://getcomposer.org/installer | /usr/bin/php',
    require => Package['php5','curl'],
    unless => '/usr/bin/test -e /vagrant/composer.phar'
  }
}
