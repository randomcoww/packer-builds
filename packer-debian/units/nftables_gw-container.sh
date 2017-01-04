cat > /etc/systemd/system/nftables_gw-container.service <<EOF
[Unit]
Description=nftables_gw-container
After=docker.service
BindsTo=docker.service

[Service]
TimeoutStartSec=0
Restart=on-failure
RestartSec=20
ExecStartPre=-/usr/bin/docker stop nftables_gw
ExecStartPre=-/usr/bin/docker kill nftables_gw
ExecStartPre=-/usr/bin/docker rm nftables_gw
ExecStartPre=-/usr/bin/docker pull randomcoww/nftables
ExecStart=/usr/bin/docker run --rm --name nftables_gw --net host --cap-add=NET_ADMIN randomcoww/nftables -r https://github.com/randomcoww/nftables-router_config.git -b master
ExecStartPost=-/bin/sh -c '/usr/bin/docker rmi \$(/usr/bin/docker images -qf dangling=true)'
ExecStop=/usr/bin/docker stop nftables_gw

[Install]
WantedBy=multi-user.target
EOF
systemctl enable nftables_gw-container.service
