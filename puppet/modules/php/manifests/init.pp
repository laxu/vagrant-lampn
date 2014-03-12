# == Class: php
#
# Installs PHP5 and necessary modules. Sets config files.
#
class php {

  helpers::addrepo {'PHP':
    repo => 'ppa:ondrej/php5-oldstable'
  }

  package { 'php5':
    ensure => present,
    require => Helpers::Addrepo['PHP']
  }

  package { 'php5-cli':
    ensure => present,
    require => Package['php5']
  }

  package { [ 'php-apc',
              'php5-curl',
              'php5-gd',
              'php5-imagick',
              'php5-mcrypt',
              'php5-memcache',
              'php5-mysql',
              'php5-sqlite',
              'php5-xsl']:
    ensure => present,
    require => Package['php5']
  }

  file {
    '/etc/php5/apache2':
      ensure => directory,
      before => File ['/etc/php5/apache2/php.ini'],
      require => Package['php5'];

    '/etc/php5/apache2/php.ini':
      source  => 'puppet:///modules/php/apache2-php.ini',
      require => Package['php5'];

    /*'/etc/php5/cli':
      ensure => directory,
      before => File ['/etc/php5/cli/php.ini'];
*/
    /*'/etc/php5/cli/php.ini':
      source  => 'puppet:///modules/php/cli-php.ini',
      require => Package['php5-cli'];*/
  }
}
