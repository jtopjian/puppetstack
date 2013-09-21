#!/bin/bash
apt-get update && apt-get install -y ubuntu-cloud-keyring
cp releases/grizzly.list /etc/apt/sources.list.d/
apt-get update
cd /etc/puppet/modules
puppet module install puppetlabs/openstack
rm -rf horizon
git clone https://github.com/stackforge/puppet-horizon horizon
