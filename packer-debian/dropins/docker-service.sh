mkdir -p /etc/systemd/system/docker.service.d
cat > /etc/systemd/system/docker.service.d/10-disable-iptables.conf <<EOF
[Service]
ExecStart=
ExecStart=/usr/bin/dockerd -H fd:// --iptables=false
ExecStartPost=-/usr/bin/docker network rm docker1
ExecStartPost=/usr/bin/docker network create --subnet=172.20.0.0/24 --ip-range=172.20.0.128/25 --gateway=172.20.0.1 -o "com.docker.network.bridge.name"="docker1" docker1
EOF
systemctl daemon-reload
