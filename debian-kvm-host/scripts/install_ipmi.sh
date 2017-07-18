#!/bin/sh
echo "install modules"

apt-get -y update
apt-get -y install ipmitool

cat >> /etc/modules <<EOF
ipmi_devintf
ipmi_si
EOF

cat > /etc/systemd/system/fancontrol.service <<EOF
[Unit]
Description=Fan Control
After=ipmievd.service

[Service]
Type=oneshot
#ExecStartPre=/usr/bin/ipmitool raw 0x30 0x45 0x01 0x01
ExecStart=/usr/bin/ipmitool raw 0x30 0x70 0x66 0x01 0x00 0x24
ExecStart=/usr/bin/ipmitool raw 0x30 0x70 0x66 0x01 0x01 0x24

[Install]
WantedBy=multi-user.target
EOF

systemctl enable fancontrol.service
