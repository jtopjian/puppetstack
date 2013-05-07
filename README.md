# Puppetstack

## About

This is a small repo that can be used to install and configure a
very basic OpenStack environment by using Puppet. It assumes the
following design choices:

  * Glance w/ file-backend
  * RabbitMQ
  * nova-network with FlatDHCP
  * libvirt and KVM

## Usage

### init.sh

Review the `init.sh` script. This is a simple bash script that:

  * Installs the ubuntu-cloud-keyring package
  * Adds the Grizzly repo to apt
  * Installs some basic packages: vim, puppet, git, and rake
  * Downloads several Puppet modules to `/etc/puppet/modules`

If everything looks good to you, run the script.

### params.pp

Next, review the `params.pp` Puppet manifest. This file contains various passwords
and settings. Modify this file as needed.

For example, if you are installing OpenStack in a virtualized environment, change
`$libvirt_type` to `qemu`.

### Install OpenStack

Once that's done, decide what role you want your current server to be:

  * All-in-One
  * Cloud Controller
  * Compute Node

Note that these scripts are able to be run without a Puppet Master server. In order
to install OpenStack on multiple servers, copy this repo to each server.

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
