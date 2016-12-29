#!/bin/bash
echo "enable disk spin down after 1 hour"

apt-get -y install hdparm

## jessie was not loading rules from /etc/udev/rules.d, put it in /lib/udev/rules.d
cat > /lib/udev/rules.d/91-hdparm.rules <<EOF
ACTION=="add|change", KERNEL=="sd*", RUN+="/sbin/hdparm -B 127 -S 242 /dev/%k"
EOF
