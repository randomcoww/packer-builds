#!/bin/sh
echo "install modules"

apt-get -y update
apt-get -y install ipmitool
apt-get clean

cat >> /etc/modules <<EOF
ipmi_devintf
ipmi_si
EOF