exec {'/usr/bin/apt-get update':}

class {'apache':}
class {'apache::mod::php':}

apache::vhost {'localhost':
	priority => '10',
	port => '80',
	docroot => '/vagrant/source'
}


class {'mysql::php':}
class {'mysql::server':
	config_hash => {
		'root_password' => 'root'
    }
}

mysql::db {'vgdb':
	user => 'vagrant',
	password => 'vagrant',
	host => 'localhost',
	grant => ['all'],
	charset => 'utf8',
	ensure => present
}


Exec['/usr/bin/apt-get update'] -> Class['apache']
Exec['/usr/bin/apt-get update'] -> Class['mysql::server']
Class['mysql::php'] ~> Class['apache']
