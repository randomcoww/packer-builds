cat > /etc/systemd/system/nftables_ns-container.service <<EOF
[Unit]
Description=nftables_ns-container
After=docker.service
BindsTo=docker.service

[Service]
TimeoutStartSec=0
Restart=on-failure
RestartSec=20
ExecStartPre=-/usr/bin/docker volume rm chef-secret-volume
ExecStartPre=/usr/bin/docker volume create --driver local --opt type=9p --opt o=ro,relatime,sync,dirsync,trans=virtio,version=9p2000.L --opt device=chef-secret --name chef-secret-volume
ExecStartPre=-/usr/bin/docker volume rm rndc-key-volume
ExecStartPre=-/usr/bin/docker stop nftables_ns
ExecStartPre=-/usr/bin/docker kill nftables_ns
ExecStartPre=-/usr/bin/docker rm nftables_ns
ExecStartPre=-/usr/bin/docker pull randomcoww/nftables
ExecStart=/usr/bin/docker run --rm --name nftables_ns -v chef-secret-volume:/etc/chef --net host --cap-add=NET_ADMIN randomcoww/chef-client:entrypoint -o 'role[nftables_ns]'
ExecStartPost=-/bin/sh -c '/usr/bin/docker rmi \$(/usr/bin/docker images -qf dangling=true)'
ExecStop=/usr/bin/docker stop nftables_ns

[Install]
WantedBy=multi-user.target
EOF
systemctl enable nftables_ns-container.service
