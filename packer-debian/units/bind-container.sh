cat > /etc/systemd/system/bind-container.service <<EOF
[Unit]
Description=bind-container
After=docker.service
BindsTo=docker.service

[Service]
TimeoutStartSec=0
Restart=on-failure
RestartSec=20
ExecStartPre=/usr/bin/docker volume create --name rndc-key-volume
ExecStartPre=-/usr/bin/docker kill bind
ExecStartPre=-/usr/bin/docker rm bind
ExecStartPre=-/usr/bin/docker pull randomcoww/bind
ExecStart=/usr/bin/docker run --rm --name bind --net host -v rndc-key-volume:/etc/bind/key randomcoww/bind -r https://github.com/randomcoww/bind-dyn_zones.git -b master
ExecStartPost=-/bin/sh -c '/usr/bin/docker rmi $(/usr/bin/docker images -qf "dangling=true")'
ExecStop=/usr/bin/docker stop bind

[Install]
WantedBy=multi-user.target
EOF
systemctl enable bind-container.service
