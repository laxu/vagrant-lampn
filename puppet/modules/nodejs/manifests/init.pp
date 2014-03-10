# == Class: nodejs
#
# Installs NodeJS and npm-check-updates
#
class nodejs {
	package { ['nodejs']:
		ensure => present;
	}
  
	package { ['npm-check-updates']:
		ensure   => latest,
		provider => 'npm',
	}
}
