# == Class: baseconfig
#
# Performs initial configuration tasks for all Vagrant boxes.
#
class helpers {

  define addrepo($repo) {
  exec { "add repo ${name}":
    command => "/usr/bin/apt-add-repository ${repo}",
    onlyif => '/usr/bin/test -e /usr/bin/apt-add-repository'
  }
    exec { "apt-get update for ${name}":
      command => '/usr/bin/apt-get update'
    }

    Exec["add repo ${name}"] -> Exec["apt-get update for ${name}"]
  }

}
