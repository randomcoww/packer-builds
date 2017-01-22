## LAN bridge

cat > /etc/systemd/network/brlan.netdev <<EOF
[NetDev]
Kind=bridge
Name=brlan
EOF

cat > /etc/systemd/network/brlan.network <<EOF
[Match]
Name=brlan

[Network]
DHCP=yes
EOF

cat > /etc/systemd/network/eth0.network <<EOF
[Match]
Name=eth0

[Network]
DHCP=no
Bridge=brlan
EOF

## Storage LAN bridge

cat > /etc/systemd/network/brstore.netdev <<EOF
[NetDev]
Kind=bridge
Name=brstore
EOF

cat > /etc/systemd/network/brstore.network <<EOF
[Match]
Name=brstore

[Network]
LinkLocalAddressing=ipv4
DHCP=no
EOF

cat > /etc/systemd/network/eth1.network <<EOF
[Match]
Name=eth1

[Network]
DHCP=no
Bridge=brstore
EOF

## load rules (not sure if needed)

systemctl daemon-reload
