cat > /etc/systemd/system/transmission-container.service <<EOF
[Unit]
Description=transmission-container
After=docker.service
BindsTo=docker.service

[Service]
TimeoutStartSec=0
Restart=on-failure
RestartSec=20
ExecStartPre=-/usr/bin/docker volume rm transmission-volume
ExecStartPre=/usr/bin/docker volume create --driver local --opt type=nfs --opt o=addr=169.254.127.21,rw,hard,vers=4 --opt device=:/torrent/transmission --name transmission-volume
ExecStartPre=-/usr/bin/docker stop transmission
ExecStartPre=-/usr/bin/docker kill transmission
ExecStartPre=-/usr/bin/docker rm transmission
ExecStartPre=-/usr/bin/docker pull randomcoww/transmission
ExecStart=/usr/bin/docker run --rm --name transmission --net container:transmission_network -v transmission-volume:/data randomcoww/transmission -d /data/downloads -i /data/incomplete -w /data/watch -c /data/info
ExecStartPost=-/bin/sh -c '/usr/bin/docker rmi \$(/usr/bin/docker images -qf dangling=true)'
ExecStop=/usr/bin/docker stop transmission

[Install]
WantedBy=multi-user.target
EOF
systemctl enable transmission-container.service
