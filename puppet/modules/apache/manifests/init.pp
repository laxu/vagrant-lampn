# == Class: apache
#
# Installs packages for Apache2, enables modules, and sets config files.
#
class apache {
  package { ['apache2', 'apache2-mpm-prefork']:
    ensure => present;
  }

  service { 'apache2':
    ensure  => running,
    require => Package['apache2'];
  }

  apache::conf { ['apache2.conf', 'envvars', 'ports.conf']: }
  apache::module { ['expires.load', 'proxy.conf', 'proxy.load', 'proxy_http.load', 'rewrite.load']: }

  file { '/var/www':
      ensure => directory;
  }

  apache::vhost { ['webapp']: }
}

# == Define: module
#
# Enables an Apache module.
#
define apache::module() {
  file { "/etc/apache2/mods-enabled/${name}":
    ensure  => link,
    target  => "/etc/apache2/mods-available/${name}",
    require => Package['apache2'],
    notify  => Service['apache2'];
  }
}

# == Define: conf
#
# Adds an Apache configuration file.
#
define apache::conf() {
  file { "/etc/apache2/${name}":
    source  => "puppet:///modules/apache/${name}",
    require => Package['apache2'],
    notify  => Service['apache2'];
  }
}


# == Define: vhost
#
# Adds and enables an Apache virtual host
#
define apache::vhost() {
  file {
    "/etc/apache2/sites-available/${name}":
      source  => "puppet:///modules/apache/vhosts/${name}",
      require => Package['apache2'],
      notify  => Service['apache2'];

    "/etc/apache2/sites-enabled/${name}":
      ensure => link,
      target => "/etc/apache2/sites-available/${name}",
      notify => Service['apache2'];

    "/var/www/${name}":
      ensure => link,
      target => "/vagrant/";
  }
}
