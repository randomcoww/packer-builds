#!/bin/sh
echo "enable systemd networking"

systemctl enable systemd-resolved
systemctl enable systemd-networkd
ln -sf /run/systemd/resolve/resolv.conf /etc/resolv.conf
systemctl disable networking
