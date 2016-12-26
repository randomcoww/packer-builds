cat > /etc/systemd/system/openvpn_proxy-container.service <<EOF
[Unit]
Description=openvpn_proxy-container
After=docker.service
BindsTo=docker.service

[Service]
TimeoutStartSec=0
Restart=on-failure
RestartSec=20
ExecStartPre=-/usr/bin/docker volume rm chef-secret-volume
ExecStartPre=/usr/bin/docker volume create --driver local --opt type=9p --opt o=ro,relatime,sync,dirsync,trans=virtio,version=9p2000.L --opt device=chef-secret --name chef-secret-volume
ExecStartPre=-/usr/bin/docker kill openvpn_proxy
ExecStartPre=-/usr/bin/docker rm openvpn_proxy
ExecStartPre=-/usr/bin/docker pull randomcoww/chef-client:entrypoint
ExecStart=/usr/bin/docker run --rm --name=openvpn_proxy --net=docker1 --ip 172.20.0.3 -v /etc/resolv.conf:/etc/resolv.conf:ro --cap-add=NET_ADMIN --device /dev/net/tun -v chef-secret-volume:/etc/chef randomcoww/chef-client:entrypoint -o openvpn_proxy::run
ExecStartPost=-/usr/bin/docker rmi $(/usr/bin/docker images -qf "dangling=true")
ExecStop=/usr/bin/docker stop openvpn_proxy

[Install]
WantedBy=multi-user.target
EOF
systemctl enable openvpn_proxy-container.service
