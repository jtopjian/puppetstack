#!/bin/bash
apt-get update && apt-get install -y ubuntu-cloud-keyring
apt-get update
echo alias nova=\"nova --no-cache\" >> ~/.bashrc
source ~/.bashrc
cd /etc/puppet/modules
git clone http://github.com/puppetlabs/puppetlabs-openstack openstack
git clone http://github.com/puppetlabs/puppetlabs-nova nova
git clone http://github.com/puppetlabs/puppetlabs-glance glance
git clone http://github.com/puppetlabs/puppetlabs-keystone keystone
git clone http://github.com/puppetlabs/puppetlabs-horizon horizon
git clone http://github.com/puppetlabs/puppetlabs-cinder cinder
git clone http://github.com/puppetlabs/puppetlabs-apache apache
git clone http://github.com/puppetlabs/puppetlabs-stdlib stdlib
git clone http://github.com/puppetlabs/puppetlabs-mysql mysql
git clone http://github.com/puppetlabs/puppetlabs-rabbitmq rabbitmq
git clone http://github.com/ripienaar/puppet-concat concat
git clone http://github.com/duritong/puppet-sysctl sysctl
git clone http://github.com/cprice-puppet/puppetlabs-inifile inifile
git clone http://github.com/saz/puppet-memcached memcached
