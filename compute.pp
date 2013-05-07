import 'params.pp'

class puppetstack-compute {

  ## Nova
  # basic nova
  class { '::nova':
    rabbit_userid      => $rabbit_user,
    rabbit_password    => $rabbit_password,
    image_service      => 'nova.image.glance.GlanceImageService',
    glance_api_servers => $glance_api_servers,
    verbose            => 'True',
    rabbit_host        => $controller_ip,
  }

  # Install / configure nova-compute
  class { '::nova::compute':
    vncserver_proxyclient_address => $private_ip,
    vncproxy_host                 => $controller_ip,
    vnc_enabled                   => true,
    enabled                       => true,
  }

  # Configure libvirt for nova-compute
  class { '::nova::compute::libvirt':
    libvirt_type     => $libvirt_type,
    vncserver_listen => '0.0.0.0',
  }

  # extra nova
  nova_config {
    'volume_api_class': value => 'nova.volume.cinder.API';
  }

}

class { 'puppetstack-compute': }
