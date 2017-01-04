cat > /etc/systemd/system/bind_network-container.service <<EOF
[Unit]
Description=bind_network-container
After=docker.service
BindsTo=docker.service

[Service]
TimeoutStartSec=0
Restart=on-failure
RestartSec=20
ExecStartPre=-/usr/bin/docker volume rm chef-secret-volume
ExecStartPre=/usr/bin/docker volume create --driver local --opt type=9p --opt o=ro,relatime,sync,dirsync,trans=virtio,version=9p2000.L --opt device=chef-secret --name chef-secret-volume
ExecStartPre=-/usr/bin/docker stop bind_network
ExecStartPre=-/usr/bin/docker kill bind_network
ExecStartPre=-/usr/bin/docker rm bind_network
ExecStartPre=-/usr/bin/docker pull randomcoww/chef-client:entrypoint
ExecStart=/usr/bin/docker run --rm --name=bind_network --net=brlan --ip 192.168.63.251 -v /etc/resolv.conf:/etc/resolv.conf:ro --cap-add=NET_ADMIN --device /dev/net/tun -v chef-secret-volume:/etc/chef randomcoww/chef-client:entrypoint -o openvpn_proxy::run
ExecStartPost=-/bin/sh -c '/usr/bin/docker rmi \$(/usr/bin/docker images -qf dangling=true)'
ExecStop=/usr/bin/docker stop bind_network

[Install]
WantedBy=multi-user.target
EOF
systemctl enable bind_network-container.service
