exec {'/usr/bin/apt-get update':}

class {'apache':}
class {'apache::mod::php':}
apache::mod {'rewrite':}

apache::vhost {'localhost':
	priority => '10',
	port => '80',
	docroot => '/vagrant/source',
	docroot_owner => 'vagrant',
	docroot_group => 'users',
	override => 'All'
}


class {'mysql::php':}
class {'mysql::server':
	config_hash => {
		'root_password' => 'root',
		'bind_address' => '0.0.0.0'
	}
}

mysql::db {'vgdb':
	user => 'vagrant',
	password => 'vagrant',
	host => '%',
	grant => ['all'],
	charset => 'utf8',
	ensure => present
}


Exec['/usr/bin/apt-get update'] -> Class['apache']
Exec['/usr/bin/apt-get update'] -> Class['mysql::server']
Class['mysql::php'] ~> Class['apache']
