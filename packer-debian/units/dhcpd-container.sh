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
ExecStartPre=-/usr/bin/docker kill dhcpd
ExecStartPre=-/usr/bin/docker rm dhcpd
ExecStartPre=-/usr/bin/docker pull randomcoww/dhcpd
ExecStart=/usr/bin/docker run --rm --name dhcpd --net host -v rndc-key-volume:/etc/dhcp/key randomcoww/dhcpd -r https://github.com/randomcoww/dhcpd_config.git -b master -i "brlan brvpn"
ExecStartPost=-/bin/sh -c '/usr/bin/docker rmi $(/usr/bin/docker images -qf "dangling=true")'
ExecStop=/usr/bin/docker stop dhcpd

[Install]
WantedBy=multi-user.target
EOF
systemctl enable dhcpd-container.service
