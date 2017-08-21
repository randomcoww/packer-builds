## copy this method: https://github.com/coreos/coreos-cloudinit/blob/master/units/90-configdrive.rules
cat > /etc/udev/rules.d/10-cloud-init-mount.rules <<EOF
ACTION!="add|change", GOTO="cloud_init_end"

SUBSYSTEM=="virtio", DRIVER=="9pnet_virtio", ATTR{mount_tag}=="cloud-init", TAG+="systemd", ENV{SYSTEMD_WANTS}+="var-lib-cloud-seed-nocloud\x2dnet.mount"

LABEL="cloud_init_end"
EOF


mkdir -p /var/lib/cloud/seed/nocloud-net
cat > /etc/systemd/system/var-lib-cloud-seed-nocloud\\x2dnet.mount <<EOF
[Unit]
Description=Mount cloud-init local directory
Before=cloud-init-local.service

[Mount]
What=cloud-init
Where=/var/lib/cloud/seed/nocloud-net
Type=9p
Options=ro,relatime,sync,dirsync,trans=virtio,version=9p2000.L
EOF
