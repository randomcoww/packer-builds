## LAN

cat > /etc/systemd/network/eth0.network <<EOF
[Match]
Name=ens2

[Network]
DHCP=yes

[Address]
Address=192.168.63.198/23
EOF

## load rules (not sure if needed)

systemctl daemon-reload
