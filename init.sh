#!/bin/bash
apt-get update && apt-get install -y ubuntu-cloud-keyring
cp releases/grizzly.list /etc/apt/sources.list.d/
apt-get update
apt-get install -y vim puppet git rake
cd /etc/puppet/modules
git clone http://github.com/stackforge/puppet-openstack openstack
git clone http://github.com/stackforge/puppet-nova nova
git clone http://github.com/stackforge/puppet-glance glance
git clone http://github.com/stackforge/puppet-keystone keystone
git clone http://github.com/stackforge/puppet-horizon horizon
git clone http://github.com/stackforge/puppet-cinder cinder
git clone http://github.com/stackforge/puppet-quantum quantum
git clone http://github.com/puppetlabs/puppetlabs-apache apache
git clone http://github.com/puppetlabs/puppetlabs-stdlib stdlib
git clone http://github.com/puppetlabs/puppetlabs-mysql mysql
git clone http://github.com/puppetlabs/puppetlabs-rabbitmq rabbitmq
git clone http://github.com/ripienaar/puppet-concat concat
git clone http://github.com/duritong/puppet-sysctl sysctl
git clone http://github.com/cprice-puppet/puppetlabs-inifile inifile
git clone http://github.com/saz/puppet-memcached memcached
