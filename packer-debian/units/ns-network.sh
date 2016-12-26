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

[Address]
Address=192.168.63.241/23
EOF

cat > /etc/systemd/network/ens2.network <<EOF
[Match]
Name=ens2

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
DHCP=no

[Address]
Address=169.254.63.241/16
EOF

cat > /etc/systemd/network/ens3.network <<EOF
[Match]
Name=ens3

[Network]
DHCP=no
Bridge=brstore
EOF

## load rules (not sure if needed)

systemctl daemon-reload
