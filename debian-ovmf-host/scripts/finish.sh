#!/bin/sh

rm /etc/systemd/network/99-fallback.network

systemctl daemon-reload

cat >> /etc/default/grub <<EOF
GRUB_TERMINAL="console serial"
GRUB_SERIAL_COMMAND="serial --unit=1 --speed=115200 --word=8 --parity=no --stop=1"
EOF

update-initramfs -u
update-grub

apt-get -y autoremove
apt-get clean
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

## if these are blank, they are generated on first boot
echo -n > /var/lib/dbus/machine-id
echo -n > /etc/machine-id
