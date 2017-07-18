#!/bin/sh
echo "install glusterfs server"

mkdir -p /etc/systemd/system/glusterfs-server.service.d
cat > /etc/systemd/system/glusterfs-server.service.d/10-mounts.conf <<EOF
[Unit]
After=zfs.target
Require=zfs-mount.service
RequiresMountsFor=/var/lib/glusterd
EOF

apt-get -y update
apt-get -y install glusterfs-server

## data path will be mounted. clean it out
systemctl stop glusterfs-server.service
rm -rf /var/lib/glusterd
