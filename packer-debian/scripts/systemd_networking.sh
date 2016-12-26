#!/bin/sh
echo "enable systemd networking"

systemctl enable systemd-resolved
systemctl enable systemd-networkd
ln -sf /run/systemd/resolve/resolv.conf /etc/resolv.conf
systemctl disable networking

## something else still keeps starting dhclient on interfaces defined in /etc/network/interfaces.
## deleting the file seems to prevent this
rm /etc/network/interfaces
