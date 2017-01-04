cat > /etc/systemd/system/bind_dyn-container.service <<EOF
[Unit]
Description=bind_dyn-container
After=docker.service
BindsTo=docker.service

[Service]
TimeoutStartSec=0
Restart=on-failure
RestartSec=20
ExecStartPre=-/usr/bin/docker volume rm chef-secret-volume
ExecStartPre=/usr/bin/docker volume create --driver local --opt type=9p --opt o=ro,relatime,sync,dirsync,trans=virtio,version=9p2000.L --opt device=chef-secret --name chef-secret-volume
ExecStartPre=-/usr/bin/docker volume rm rndc-key-volume
ExecStartPre=/usr/bin/docker volume create --name rndc-key-volume
ExecStartPre=-/usr/bin/docker stop bind_dyn
ExecStartPre=-/usr/bin/docker kill bind_dyn
ExecStartPre=-/usr/bin/docker rm bind_dyn
ExecStartPre=-/usr/bin/docker pull randomcoww/bind
ExecStart=/usr/bin/docker run --rm --name bind_dyn -v chef-secret-volume:/etc/chef --net=brlan --ip 192.168.63.250 -v /etc/resolv.conf:/etc/resolv.conf:ro -v rndc-key-volume:/etc/bind/key randomcoww/chef-client:entrypoint -o 'role[bind_dyn]'
ExecStartPost=-/bin/sh -c '/usr/bin/docker rmi \$(/usr/bin/docker images -qf dangling=true)'
ExecStop=/usr/bin/docker stop bind_dyn

[Install]
WantedBy=multi-user.target
EOF
systemctl enable bind_dyn-container.service
