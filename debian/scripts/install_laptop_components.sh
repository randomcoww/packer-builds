#!/bin/bash
echo "install laptop components"

## no gui
apt-get -y update
apt-get -y install firmware-realtek wpasupplicant nfs-common ipmitool

## packer
wget -O /tmp/packer.zip $PACKER_URL
unzip /tmp/packer.zip -d /usr/local/bin
rm /tmp/packer.zip

## chefdk
wget -O /tmp/chefdk.deb $CHEFDK_URL
dpkg -i /tmp/chefdk.deb
rm /tmp/chefdk.deb
