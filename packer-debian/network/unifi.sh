## LAN

cat > /etc/systemd/network/eth0.network <<EOF
[Match]
Name=eth0

[Network]
DHCP=yes
EOF

## load rules (not sure if needed)

systemctl daemon-reload
