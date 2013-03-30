# Network
$public_interface  = 'eth0'
$private_interface = 'eth0'
$controller_ip = '10.16.0.30'
$keystone_host = $controller_ip

# database config
$mysql_root_password     = 'password'
$keystone_mysql_password = 'password'
$glance_mysql_password   = 'password'
$nova_mysql_password     = 'password'
$cinder_mysql_password   = 'password'
$quantum_mysql_password  = 'password'

$mysql_allowed_hosts        = ['%']

$keystone_db = "mysql://keystone:${keystone_mysql_password}@${controller_ip}/keystone"
$nova_db     = "mysql://nova:${nova_mysql_password}@${controller_ip}/nova"
$glance_db   = "mysql://glance:${glance_mysql_password}@${controller_ip}/glance"
$cinder_db   = "mysql://cinder:${cinder_mysql_password}@${controller_ip}/cinder"

# keystone settings
$keystone_admin_token    = '12345'
$admin_email             = 'keystone@localhost'
$keystone_admin_password = 'password'
$keystone_admin_tenant   = 'admin'
$glance_user_password    = 'password'
$nova_user_password      = 'password'
$cinder_user_password    = 'password'
$quantum_user_password   = 'password'

# Nova
$glance_api_servers = "${controller_ip}:9292"
$rabbit_password    = 'password'
$rabbit_user        = 'nova'
$libvirt_type       = 'qemu'
$network_type       = 'nova'
$fixed_range        = '10.255.0.0/24'
$num_networks       = 1

# Horizon
$secret_key        = 'secret_key'

# Misc
$verbose           = 'True'

#### end shared variables #################
