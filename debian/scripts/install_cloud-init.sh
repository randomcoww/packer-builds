#!/bin/sh
echo "install cloud-init"

apt-get update -y
apt-get -y install cloud-init net-tools

mkdir -p /var/lib/cloud/seed/nocloud-net
