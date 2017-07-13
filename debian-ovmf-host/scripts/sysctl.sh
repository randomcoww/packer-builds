#!/bin/sh
echo "sysctl options"

cat >> /etc/sysctl.conf <<EOF
vm.swappiness = 0
net.ipv4.ip_forward = 1
net.ipv4.ip_nonlocal_bind = 1
EOF
