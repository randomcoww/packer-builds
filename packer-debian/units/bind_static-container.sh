cat > /etc/systemd/system/bind_static-container.service <<EOF
[Unit]
Description=bind_static-container
After=docker.service
BindsTo=docker.service

[Service]
TimeoutStartSec=0
Restart=on-failure
RestartSec=20
ExecStartPre=-/usr/bin/docker kill bind_static
ExecStartPre=-/usr/bin/docker rm bind_static
ExecStartPre=-/usr/bin/docker pull randomcoww/bind
ExecStart=/usr/bin/docker run --rm --name bind_static --net host randomcoww/bind -r https://github.com/randomcoww/bind-static_zones.git -b master
ExecStartPost=-/bin/sh -c '/usr/bin/docker rmi $(/usr/bin/docker images -qf "dangling=true")'
ExecStop=/usr/bin/docker stop bind_static

[Install]
WantedBy=multi-user.target
EOF
systemctl enable bind_static-container.service
