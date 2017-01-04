cat > /etc/systemd/system/transmission_network-container.service <<EOF
[Unit]
Description=transmission_network-container
After=docker.service
BindsTo=docker.service

[Service]
TimeoutStartSec=0
Restart=on-failure
RestartSec=20
ExecStartPre=-/usr/bin/docker volume rm chef-secret-volume
ExecStartPre=/usr/bin/docker volume create --driver local --opt type=9p --opt o=ro,relatime,sync,dirsync,trans=virtio,version=9p2000.L --opt device=chef-secret --name chef-secret-volume
ExecStartPre=-/usr/bin/docker volume rm rndc-key-volume
ExecStartPre=-/usr/bin/docker stop transmission_network
ExecStartPre=-/usr/bin/docker kill transmission_network
ExecStartPre=-/usr/bin/docker rm transmission_network
ExecStartPre=-/usr/bin/docker pull randomcoww/chef-client:entrypoint
ExecStart=/usr/bin/docker run --rm --name=transmission_network -v chef-secret-volume:/etc/chef --net=docker1 --ip 172.20.0.3 -v /etc/resolv.conf:/etc/resolv.conf:ro --cap-add=NET_ADMIN --device /dev/net/tun -v chef-secret-volume:/etc/chef randomcoww/chef-client:entrypoint -o 'role[vpn_network_transmission]'
ExecStartPost=-/bin/sh -c '/usr/bin/docker rmi \$(/usr/bin/docker images -qf dangling=true)'
ExecStop=/usr/bin/docker stop transmission_network

[Install]
WantedBy=multi-user.target
EOF
systemctl enable transmission_network-container.service
