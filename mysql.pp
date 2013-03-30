class puppetstack-mysql {
  ## MySQL
  # Install and configure MySQL Server
  class { '::mysql::server':
    config_hash => {
      'root_password' => $mysql_root_password,
      'bind_address'  => '0.0.0.0'
    },
  }
  
  # This removes default users and guest access
  class { '::mysql::server::account_security': }
  
  # Create the Keystone db
  class { '::keystone::db::mysql':
    password      => $keystone_mysql_password,
    allowed_hosts => $mysql_allowed_hosts,
    user          => 'keystone',
  }
  
  # Create the Glance db
  class { '::glance::db::mysql':
    password      => $glance_mysql_password,
    allowed_hosts => $mysql_allowed_hosts,
  }
  
  # Create the Nova db
  class { '::nova::db::mysql':
    password      => $nova_mysql_password,
    allowed_hosts => $mysql_allowed_hosts,
  }
  
  # Create the Cinder db
  class { '::cinder::db::mysql':
    password      => $cinder_mysql_password,
    allowed_hosts => $mysql_allowed_hosts,
  }
}
