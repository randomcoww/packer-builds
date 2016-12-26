#!/bin/sh

## hack to make sure name resolution works during provisioning.
## This file is replaced with a systemd-reolved link at the end.
echo nameserver 8.8.8.8 > /etc/resolv.conf

## other
echo vm.swappiness = 0 >> /etc/sysctl.conf
apt-get -y install ntp
