cat > /etc/systemd/system/etc-chef.mount <<EOF
[Unit]
Description=Mount Chef secret

[Mount]
What=chef-secret
Where=/etc/chef
Type=9p
Options=ro,relatime,sync,dirsync,trans=virtio,version=9p2000.L

[Install]
WantedBy=multi-user.target
EOF
systemctl enable etc-chef.mount
