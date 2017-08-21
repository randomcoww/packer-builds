#!/bin/sh
echo "enable ipmi fan control"

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
# set full speed
# ExecStartPre=/usr/bin/ipmitool raw 0x30 0x45 0x01 0x01
# fan control 0x30 0x70 0x66
# get 0x00, set 0x01
# zone FAN 1,2,.. 0x00, FAN A,B,.. 0x01
# duty cycle 0x00-0x64
ExecStart=/usr/bin/ipmitool raw 0x30 0x70 0x66 0x01 0x00 0x20
ExecStart=/usr/bin/ipmitool raw 0x30 0x70 0x66 0x01 0x01 0x20

[Install]
WantedBy=multi-user.target
EOF

systemctl enable fancontrol.service
