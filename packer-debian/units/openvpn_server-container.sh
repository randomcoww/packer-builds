cat > /etc/systemd/system/openvpn_server-container.service <<EOF
[Unit]
Description=openvpn_server-container
After=docker.service
BindsTo=docker.service

[Service]
TimeoutStartSec=0
Restart=on-failure
RestartSec=20
ExecStartPre=-/usr/bin/docker volume rm chef-secret-volume
ExecStartPre=/usr/bin/docker volume create --driver local --opt type=9p --opt o=ro,relatime,sync,dirsync,trans=virtio,version=9p2000.L --opt device=chef-secret --name chef-secret-volume
ExecStartPre=-/usr/bin/docker stop openvpn_server
ExecStartPre=-/usr/bin/docker kill openvpn_server
ExecStartPre=-/usr/bin/docker rm openvpn_server
ExecStartPre=-/usr/bin/docker pull randomcoww/chef-client:entrypoint
ExecStart=/usr/bin/docker run --rm --name openvpn_server --cap-add=NET_ADMIN --net host --device /dev/net/tun -v chef-secret-volume:/etc/chef randomcoww/chef-client:entrypoint -o openvpn_server::run
ExecStartPost=-/bin/sh -c '/usr/bin/docker rmi \$(/usr/bin/docker images -qf dangling=true)'
ExecStop=/usr/bin/docker stop openvpn_server

[Install]
WantedBy=multi-user.target
EOF
systemctl enable openvpn_server-container.service
