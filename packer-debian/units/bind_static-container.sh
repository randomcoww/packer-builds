cat > /etc/systemd/system/bind_static-container.service <<EOF
[Unit]
Description=bind_static-container
After=docker.service
BindsTo=docker.service

[Service]
TimeoutStartSec=0
Restart=on-failure
RestartSec=20
ExecStartPre=-/usr/bin/docker volume rm chef-secret-volume
ExecStartPre=/usr/bin/docker volume create --driver local --opt type=9p --opt o=ro,relatime,sync,dirsync,trans=virtio,version=9p2000.L --opt device=chef-secret --name chef-secret-volume
ExecStartPre=-/usr/bin/docker volume rm rndc-key-volume
ExecStartPre=-/usr/bin/docker stop bind_static
ExecStartPre=-/usr/bin/docker kill bind_static
ExecStartPre=-/usr/bin/docker rm bind_static
ExecStartPre=-/usr/bin/docker pull randomcoww/bind
ExecStart=/usr/bin/docker run --rm --name bind_static -v chef-secret-volume:/etc/chef --net container:bind_network randomcoww/chef-client:entrypoint -o 'role[bind_static]'
ExecStartPost=-/bin/sh -c '/usr/bin/docker rmi \$(/usr/bin/docker images -qf dangling=true)'
ExecStop=/usr/bin/docker stop bind_static

[Install]
WantedBy=multi-user.target
EOF
systemctl enable bind_static-container.service
