cat > /etc/systemd/system/nftables_router-container.service <<EOF
[Unit]
Description=nftables-container
After=docker.service
BindsTo=docker.service

[Service]
TimeoutStartSec=0
Restart=on-failure
RestartSec=20
ExecStartPre=-/usr/bin/docker kill nftables
ExecStartPre=-/usr/bin/docker rm nftables
ExecStartPre=-/usr/bin/docker pull randomcoww/nftables
ExecStart=/usr/bin/docker run --rm --name nftables --net host --cap-add=NET_ADMIN randomcoww/nftables -r https://github.com/randomcoww/nftables-router_config.git -b master
ExecStartPost=-/bin/sh -c '/usr/bin/docker rmi $(/usr/bin/docker images -qf "dangling=true")'
ExecStop=/usr/bin/docker stop nftables

[Install]
WantedBy=multi-user.target
EOF
systemctl enable nftables_router-container.service
