cat > /etc/systemd/system/dhcpd-container.service <<EOF
[Unit]
Description=dhcpd-container
After=docker.service
BindsTo=docker.service

[Service]
TimeoutStartSec=0
Restart=on-failure
RestartSec=20
ExecStartPre=-/usr/bin/docker volume rm chef-secret-volume
ExecStartPre=/usr/bin/docker volume create --driver local --opt type=9p --opt o=ro,relatime,sync,dirsync,trans=virtio,version=9p2000.L --opt device=chef-secret --name chef-secret-volume
ExecStartPre=-/usr/bin/docker volume rm rndc-key-volume
ExecStartPre=-/usr/bin/docker volume rm rndc-key-volume
ExecStartPre=/usr/bin/docker volume create --name rndc-key-volume
ExecStartPre=-/usr/bin/docker stop dhcpd
ExecStartPre=-/usr/bin/docker kill dhcpd
ExecStartPre=-/usr/bin/docker rm dhcpd
ExecStartPre=-/usr/bin/docker pull randomcoww/dhcpd
ExecStartPre=/usr/bin/docker create --name dhcpd -v chef-secret-volume:/etc/chef --net=brlan --ip 192.168.63.249 -v /etc/resolv.conf:/etc/resolv.conf:ro -v rndc-key-volume:/etc/dhcp/key randomcoww/chef-client:entrypoint -o 'role[dhcpd_server]'
ExecStartPre=/usr/bin/docker network --ip 192.168.31.249 connect brvpn dhcpd
ExecStart=/usr/bin/docker start -i dhcpd
ExecStartPost=-/bin/sh -c '/usr/bin/docker rmi \$(/usr/bin/docker images -qf dangling=true)'
ExecStop=/usr/bin/docker stop dhcpd

[Install]
WantedBy=multi-user.target
EOF
systemctl enable dhcpd-container.service
