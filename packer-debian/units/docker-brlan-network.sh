cat > /etc/systemd/system/docker-brlan-network.service <<EOF
[Unit]
Description=docker-brlan-network
After=docker.service
BindsTo=docker.service

[Service]
TimeoutStartSec=0
Restart=on-failure
RestartSec=20
ExecStart=-/usr/bin/docker network create -d bridge --subnet=192.168.62.0/23 --ip-range=192.168.63.128/25 --gateway=192.168.62.241 -o "com.docker.network.bridge.name"="brlan" brlan

[Install]
WantedBy=multi-user.target
EOF
systemctl enable docker-brlan-network.service
