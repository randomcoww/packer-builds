cat > /etc/systemd/system/mpd-container.service <<EOF
[Unit]
Description=mpd-container
After=docker.service
BindsTo=docker.service

[Service]
TimeoutStartSec=0
Restart=on-failure
RestartSec=20
ExecStartPre=-/usr/bin/docker volume rm mpd-data-volume
ExecStartPre=/usr/bin/docker volume create --driver local --opt type=nfs --opt o=addr=169.254.127.21,rw,hard,vers=4 --opt device=:/music --name mpd-data-volume
ExecStartPre=/usr/bin/docker volume create --name mpd-cache-volume
ExecStartPre=/usr/bin/docker volume create --name mpd-playlists-volume
ExecStartPre=-/usr/bin/docker stop mpd
ExecStartPre=-/usr/bin/docker kill mpd
ExecStartPre=-/usr/bin/docker rm mpd
ExecStartPre=-/usr/bin/docker pull randomcoww/mpd
ExecStart=/usr/bin/docker run --rm --name mpd --net=docker1 --ip=172.20.0.4 -v mpd-cache-volume:/var/lib/mpd/cache -v mpd-playlists-volume:/var/lib/mpd/playlists -v mpd-volume:/var/lib/mpd/music randomcoww/mpd
ExecStartPost=-/bin/sh -c '/usr/bin/docker rmi \$(/usr/bin/docker images -qf dangling=true)'
ExecStop=/usr/bin/docker stop mpd

[Install]
WantedBy=multi-user.target
EOF
systemctl enable mpd-container.service
