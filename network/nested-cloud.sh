#!/bin/bash
apt-get install -y bridge-utils
cat <<EOF >/etc/network/interfaces
auto lo
iface lo inet loopback

auto eth0
iface eth0 inet dhcp
pre-up ip tunnel add gt_cloud mode gretap remote XXX local XXX nopmtudisc
up ip link set mtu 1500 gt_cloud
post-down ip tunnel del gt_cloud

auto br100
iface br100 inet static
        address 192.168.255.X
        netmask 255.255.255.0
        bridge_ports gt_cloud
        bridge_stp off
        bridge_fd 0
        bridge_maxwait 0
EOF
