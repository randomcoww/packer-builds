cat > /etc/systemd/system/dhcpd-container.service <<EOF
[Unit]
Description=dhcpd-container
After=docker.service
BindsTo=docker.service

[Service]
TimeoutStartSec=0
Restart=on-failure
RestartSec=20
ExecStartPre=/usr/bin/docker volume create --name rndc-key-volume
ExecStartPre=-/usr/bin/docker stop dhcpd
ExecStartPre=-/usr/bin/docker kill dhcpd
ExecStartPre=-/usr/bin/docker rm dhcpd
ExecStartPre=-/usr/bin/docker pull randomcoww/dhcpd
ExecStartPre=/usr/bin/docker create --name dhcpd --net=brlan --ip 192.168.63.249 -v /etc/resolv.conf:/etc/resolv.conf:ro -v rndc-key-volume:/etc/dhcp/key randomcoww/dhcpd -r https://github.com/randomcoww/dhcpd_config.git -b master -i "eth0 eth1"
ExecStartPre=/usr/bin/docker network --ip 192.168.31.249 connect brvpn dhcpd
ExecStart=/usr/bin/docker start -i dhcpd
ExecStartPost=-/bin/sh -c '/usr/bin/docker rmi \$(/usr/bin/docker images -qf dangling=true)'
ExecStop=/usr/bin/docker stop dhcpd

[Install]
WantedBy=multi-user.target
EOF
systemctl enable dhcpd-container.service
