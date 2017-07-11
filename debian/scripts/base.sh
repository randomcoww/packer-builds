#!/bin/sh

echo vm.swappiness = 0 >> /etc/sysctl.conf
apt-get -y update
apt-get -y -o Dpkg::Options::='--force-confdef' -o Dpkg::Options::='--force-confold' dist-upgrade
apt-get -y install ntp vim
