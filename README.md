# Puppetstack

## About

This is a small repo that can be used to install and configure a very basic OpenStack environment by using Puppet. It assumes the following design choices:

  * Glance w/ file-backend
  * RabbitMQ
  * nova-network with FlatDHCP
  * libvirt and KVM

## Usage

Puppetstack is *not* a Puppet module. It's simply a repository of Puppet manifests that are to be run in a standalone Puppet environment -- not a server/client environment.

Puppetstack can currently be used to install three types of OpenStack server roles:

1. All-in-one
2. Cloud Controller
3. Compute Node

No matter which role you choose, you will need to perform the following steps on *each* server:

### Networking

Make sure the network configuration between your servers is correct before proceeding. The `network` folder contains two example scripts for unusual (but common for testing) configurations.

#### single-interface.sh

This script is for servers that only have one interface. It will create a bridge interface and add the real interface to the bridge. If you configure OpenStack for FlatDHCP networking, make sure to set the `flat_interface` as the same name as the bridge.

#### nested-cloud.sh

This script is for running multi-host OpenStack clouds inside an existing OpenStack environment. In order for multiple OpenStack nodes to be able to fully communicate with each other inside an existing cloud, a Layer 2 tunnel needs to be created.

This script will create a `gretap` tunnel between two endpoints. The tunnel is attached to the real interface of the server (as discovered by the IP addresses you choose to use). Next, a bridge is created and the `gretap` tunnel is added to the bridge. Finally, the bridge is given its own prive IP address. With all of this in place, this effectively creates an entire L2/L3 network embedded inside the host cloud.

Note that a `gretap` tunnel needs created for all combinations of nodes, so it's easiest to just work with one cloud controller and one compute node (total of two tunnels). Adding a second compute node would require six tunnels.

### init.sh

Review the `init.sh` script. This is a simple bash script that:

  * Installs the ubuntu-cloud-keyring package
  * Adds the Grizzly repo to apt
  * Downloads several Puppet modules to `/etc/puppet/modules`

If everything looks good to you, run the script.

### params.pp

Next, review the `params.pp` Puppet manifest. This file contains various passwords
and settings. Modify this file as needed.

For example, if you are installing OpenStack in a virtualized environment, change
`$libvirt_type` to `qemu`.

### Install OpenStack

Once these steps are done on each server, apply the role to the server:

#### All in One

An all-in-one server runs all components of OpenStack on a single server. This is
useful for quick testing.

```bash
puppet apply --verbose all-in-one.pp
```

#### Cloud Controller

A Cloud Controller does everything but host virtual machines. It runs the
following services:

  * Glance
  * Keystone
  * MySQL
  * RabbitMQ
  * Nova (except nova-compute)
  * Cinder

```bash
puppet apply --verbose controller.pp
```

#### Compute Node

A Compute Node hosts virtual machines. It runs the `nova-compute` service.

```bash
puppet apply --verbose compute.pp
```

### Volumes

While these scripts install and configure Cinder, they do not actually
configure Cinder with a block storage driver. This must be done manually.

### Post-Install

The `nova.sh` script is a small bash script that does the following:

  * Downloads the CirrOS image
  * Adds it to Glance
  * Generates a SSH key and adds it to nova
  * Allows port 22 and ICMP to instances
