#
class puppetstack-compute {

  ## Nova
  # basic nova
  class { '::nova':
    sql_connection     => $nova_db,
    rabbit_userid      => $rabbit_user,
    rabbit_password    => $rabbit_password,
    image_service      => 'nova.image.glance.GlanceImageService',
    glance_api_servers => $glance_api_servers,
    verbose            => 'True',
    rabbit_host        => $cloud_public_ip,
  }

  # Install / configure nova-compute
  class { '::nova::compute':
    enabled => true,
  }

  # Configure libvirt for nova-compute
  class { '::nova::compute::libvirt':
    libvirt_type => $libvirt_type,
  }

  # extra nova
  nova_config {
    'volume_api_class': value => 'nova.volume.cinder.API';
  }

  class { 'cinder::base':
    verbose         => 'True',
    sql_connection  => $cinder_db,
    rabbit_password => $rabbit_password,
    rabbit_host     => $cloud_private_ip,
  }

  class { 'cinder::volume': }

}
