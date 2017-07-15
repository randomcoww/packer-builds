#!/bin/sh
echo "install docker"

mkdir -p /etc/systemd/system/docker.service.d
cat > /etc/systemd/system/docker.service.d/10-dropin.conf <<EOF
[Service]
Restart=always
RestartSec=5
ExecStart=
ExecStart=/usr/bin/dockerd -H fd:// --log-driver=journald --ip-masq=false --iptables=false
EOF

apt-get -y update
apt-get -y install \
     apt-transport-https \
     ca-certificates \
     curl \
     gnupg2 \
     software-properties-common

curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -

add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/debian \
   $(lsb_release -cs) \
   stable"

apt-get -y update
apt-get -y install docker-ce
