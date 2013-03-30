#!/bin/bash
#
# assumes that resonable credentials have been stored at
# /root/auth
source /root/openrc

wget https://launchpad.net/cirros/trunk/0.3.0/+download/cirros-0.3.0-x86_64-disk.img
glance add name='cirros image' is_public=true container_format=bare disk_format=qcow2 < cirros-0.3.0-x86_64-disk.img
IMAGE_ID=`glance index | grep 'cirros image' | head -1 |  awk -F' ' '{print $1}'`

# create a pub key
ssh-keygen -f /tmp/id_rsa -t rsa -N ''
nova keypair-add --pub_key /tmp/id_rsa.pub default_key

# Modify default secgroup
nova secgroup-add-rule default tcp 22 22 0.0.0.0/24
nova secgroup-add-rule default icmp -1 -1 0.0.0.0/24

# Boot an image
nova boot --flavor 1 --image ${IMAGE_ID} --key_name default_key test_vm
nova show test_vm
