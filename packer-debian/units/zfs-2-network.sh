## LAN

cat > /etc/systemd/network/eth0.network <<EOF
[Match]
Name=ens2

[Network]
DHCP=yes

[Address]
Address=192.168.63.21/23
EOF

## Storage LAN

cat > /etc/systemd/network/eth1.network <<EOF
[Match]
Name=ens3

[Network]
Address=169.254.127.21/16
EOF

## load rules (not sure if needed)

systemctl daemon-reload
