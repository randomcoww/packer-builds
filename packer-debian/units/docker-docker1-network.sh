cat > /etc/systemd/system/docker-docker1-network.service <<EOF
[Unit]
Description=docker-brlan-network
After=docker.service
BindsTo=docker.service

[Service]
TimeoutStartSec=0
Restart=on-failure
RestartSec=20
ExecStartPre=-/usr/bin/docker network rm docker1
ExecStart=/usr/bin/docker network create -d bridge --subnet=172.20.0.0/24 --ip-range=172.20.0.128/25 --gateway=172.20.0.1 -o "com.docker.network.bridge.name"="docker1" docker1

[Install]
WantedBy=multi-user.target
EOF
systemctl enable docker-docker1-network.service
