#!/bin/bash
ifconfig eth0:0 10.255.0.1 netmask 255.255.255.0
ifconfig eth0:0 up
