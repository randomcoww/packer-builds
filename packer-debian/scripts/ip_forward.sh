#!/bin/sh
echo "enable IP forward"

echo net.ipv4.ip_forward = 1 >> /etc/sysctl.conf
echo net.ipv6.ip_forward = 1 >> /etc/sysctl.conf
