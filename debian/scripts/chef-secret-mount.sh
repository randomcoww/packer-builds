## mount chef secret from host
## copy this method: https://github.com/coreos/coreos-cloudinit/blob/master/units/90-configdrive.rules
cat > /etc/udev/rules.d/80-chef-secret-mount.rules <<EOF
ACTION!="add|change", GOTO="chef_secret_end"

SUBSYSTEM=="virtio", DRIVER=="9pnet_virtio", ATTR{mount_tag}=="chef-secret", TAG+="systemd", ENV{SYSTEMD_WANTS}+="etc-chef.mount"

LABEL="chef_secret_end"
EOF


cat > /etc/systemd/system/etc-chef.mount <<EOF
[Unit]
Description=Mount Chef secret
Before=chef-client.service

[Mount]
What=chef-secret
Where=/etc/chef
Type=9p
Options=ro,relatime,sync,dirsync,trans=virtio,version=9p2000.L
EOF
