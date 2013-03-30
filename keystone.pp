# keystone configuration
class puppetstack-keystone {
  ## Keystone
  class { '::keystone':
    verbose        => 'True',
    debug          => 'True',
    catalog_type   => 'sql',
    admin_token    => $keystone_admin_token,
    sql_connection => $keystone_db,
    enabled        => true,
  }

  # Setup the admin user
  class { '::keystone::roles::admin':
    email        => 'root@localhost',
    password     => $keystone_admin_password,
    admin_tenant => $keystone_admin_tenant,
  }

  # Setup the Keystone Identity Endpoint
  class { '::keystone::endpoint':
    public_address   => $keystone_host,
    admin_address    => $keystone_host,
    internal_address => $keystone_host,
  }

  # Configure Glance endpoint in Keystone
  class { '::glance::keystone::auth':
    password         => $glance_user_password,
    public_address   => $keystone_host,
    admin_address    => $keystone_host,
    internal_address => $keystone_host,
  }

  # Configure Nova endpoint in Keystone
  class { '::nova::keystone::auth':
    password         => $nova_user_password,
    public_address   => $keystone_host,
    admin_address    => $keystone_host,
    internal_address => $keystone_host,
    cinder           => true,
  }

  # Configure Nova endpoint in Keystone
  class { '::cinder::keystone::auth':
    password         => $cinder_user_password,
    public_address   => $keystone_host,
    admin_address    => $keystone_host,
    internal_address => $keystone_host,
  }

}
