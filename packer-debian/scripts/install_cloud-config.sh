#!/bin/sh
echo "install cloud-init"

apt-get update -y
apt-get -y install cloud-init netstat
apt-get clean
mkdir -p /var/lib/cloud/seed/nocloud-net

cat > /lib/udev/rules.d/10-cloud-init.rules <<EOF
ACTION!="add|change", GOTO="cloud_init_end"

SUBSYSTEM=="virtio", DRIVER=="9pnet_virtio", ATTR{mount_tag}=="cloud-init", TAG+="systemd", ENV{SYSTEMD_WANTS}+="var-lib-cloud-seed-nocloud\x2dnet.mount"

LABEL="cloud_init_end"
EOF
