#!/bin/bash
echo "enable disk spin down after 1 hour"

apt-get -y install hdparm
cat > /etc/udev/rules.d/50-hdparm.rules <<EOF
ACTION=="add|change", KERNEL=="sd*", RUN+="/sbin/hdparm -B 127 -S 242 /dev/%k"
EOF
