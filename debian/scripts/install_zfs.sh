#!/bin/bash
echo "install ZFS on Linux"

echo options zfs zfs_arc_max=$ZFS_ARC_MAX >> /etc/modprobe.d/zfs.conf

apt-get -y install linux-headers-$(uname -r)
apt-get -y install zfs-dkms zfsutils-linux

systemctl enable zfs-import-scan
