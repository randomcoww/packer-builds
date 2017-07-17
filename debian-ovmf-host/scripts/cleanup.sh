#!/bin/sh

systemctl daemon-reload
update-initramfs -u
update-grub

apt-get -y autoremove
apt-get clean
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

## if these are blank, they are generated on first boot
echo -n > /var/lib/dbus/machine-id
echo -n > /etc/machine-id
