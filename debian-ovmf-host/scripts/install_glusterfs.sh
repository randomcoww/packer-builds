#!/bin/sh
echo "install glusterfs server"

mkdir -p /etc/systemd/system/glusterfs-server.service.d
cat > /etc/systemd/system/glusterfs-server.service.d/10-mounts.conf <<EOF
[Unit]
After=zfs-mount.service
Requires=zfs-mount.service
EOF

apt-get -y update
apt-get -y install glusterfs-server
