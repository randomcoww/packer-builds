cat > /etc/systemd/system/bind_dyn-container.service <<EOF
[Unit]
Description=bind_dyn-container
After=docker.service
BindsTo=docker.service

[Service]
TimeoutStartSec=0
Restart=on-failure
RestartSec=20
ExecStartPre=/usr/bin/docker volume create --name rndc-key-volume
ExecStartPre=-/usr/bin/docker kill bind_dyn
ExecStartPre=-/usr/bin/docker rm bind_dyn
ExecStartPre=-/usr/bin/docker pull randomcoww/bind
ExecStart=/usr/bin/docker run --rm --name bind_dyn --net host -v rndc-key-volume:/etc/bind/key randomcoww/bind -r https://github.com/randomcoww/bind-dyn_zones.git -b master
ExecStartPost=-/bin/sh -c '/usr/bin/docker rmi $(/usr/bin/docker images -qf "dangling=true")'
ExecStop=/usr/bin/docker stop bind_dyn

[Install]
WantedBy=multi-user.target
EOF
systemctl enable bind_dyn-container.service
