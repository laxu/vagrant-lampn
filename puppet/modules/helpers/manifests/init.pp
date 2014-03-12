# == Class: baseconfig
#
# Performs initial configuration tasks for all Vagrant boxes.
#
class helpers {

  define addrepo($repo) {
    exec { "add repo ${name}":
      command => "/usr/bin/apt-add-repository ${repo}",
      require => Package['python-software-properties']
    }

    exec { "apt-get update for ${name}":
      command => '/usr/bin/apt-get update'
    }

    Exec["add repo ${name}"] ~> Exec["apt-get update for ${name}"]
  }

}
