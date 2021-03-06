import 'keystone.pp'
import 'mysql.pp'
import 'params.pp'

# cloud configuration
class puppetstack-controller {

  ## Glance
  # Install and configure glance-api
  class { '::glance::api':
    verbose           => 'True',
    debug             => 'True',
    auth_host         => $keystone_host,
    keystone_password => $glance_user_password,
    sql_connection    => $glance_db,
  }

  # Install and configure glance-registry
  class { '::glance::registry':
    verbose           => 'True',
    debug             => 'True',
    auth_host         => $keystone_host,
    keystone_password => $glance_user_password,
    sql_connection    => $glance_db,
  }

  # Configure file storage backend
  class { '::glance::backend::file': }

  ## Nova
  # Install / configure rabbitmq
  class { '::nova::rabbitmq':
    userid   => $rabbit_user,
    password => $rabbit_password,
  }

  # Configure Nova
  class { '::nova':
    sql_connection     => $nova_db,
    rabbit_userid      => $rabbit_user,
    rabbit_password    => $rabbit_password,
    glance_api_servers => $glance_api_servers,
    verbose            => 'True',
    rabbit_host        => $keystone_host,
  }

  # Configure nova-api
  class { '::nova::api':
    admin_password    => $nova_user_password,
    auth_host         => $keystone_host,
    admin_tenant_name => 'services',
    enabled           => true,
  }

  # Configure nova-network
  class { '::nova::network':
    private_interface => $private_interface,
    public_interface  => $public_interface,
    fixed_range       => $fixed_range,
    network_manager   => 'nova.network.manager.FlatDHCPManager',
    num_networks      => $num_networks,
    enabled           => true,
  }

  # a bunch of nova services that require no configuration
  class { [
    'nova::scheduler',
    'nova::objectstore',
    'nova::cert',
    'nova::consoleauth',
    'nova::conductor',
   ]:
     enabled => true,
  }

  ## Cinder
  # base
  class { '::cinder':
    verbose         => 'True',
    sql_connection  => $cinder_db,
    rabbit_password => $rabbit_password,
    rabbit_userid   => $rabbit_user,
  }

  # cinder api
  class { '::cinder::api':
    keystone_password  => $cinder_keystone_password,
    keystone_auth_host => $keystone_host,
    keystone_tenant    => 'services',
  }

  # cinder scheduler
  class { '::cinder::scheduler': }

  ## Generate an openrc file
  class { '::openstack::auth_file':
    controller_node      => $controller_ip,
    admin_password       => $keystone_admin_password,
    keystone_admin_token => $keystone_admin_token,
    admin_tenant         => $keystone_admin_tenant,
  }

  ## Horizon
  class { '::horizon':
    secret_key => $horizon_secret_key,
  }

}

class { 'puppetstack-mysql': } ->
class { 'puppetstack-keystone': } ->
class { 'puppetstack-controller': }
