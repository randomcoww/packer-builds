#!/bin/sh
echo "install ipmi modules"

apt-get -y update
apt-get -y install ipmitool
