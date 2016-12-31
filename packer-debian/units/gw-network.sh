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
DHCP=no

[Address]
Address=192.168.62.241/23
EOF

cat > /etc/systemd/network/eth0.network <<EOF
[Match]
Name=eth0

[Network]
DHCP=no
Bridge=brlan
EOF

## WAN

cat > /etc/systemd/network/eth1.network <<EOF
[Match]
Name=eth1

[Network]
DHCP=yes
DNS=8.8.8.8
EOF

## VPN bridge

cat > /etc/systemd/network/brvpn.netdev <<EOF
[NetDev]
Kind=bridge
Name=brvpn
EOF

cat > /etc/systemd/network/brvpn.network <<EOF
[Match]
Name=brvpn

[Network]
DHCP=no

[Address]
Address=192.168.30.241/23
EOF

cat > /etc/systemd/network/eth2.network <<EOF
[Match]
Name=eth2

[Network]
DHCP=no
Bridge=brvpn
EOF

cat > /etc/systemd/network/tap.network <<EOF
[Match]
Name=tap*

[Network]
DHCP=no
Bridge=brvpn
EOF

## load rules (not sure if needed)

systemctl daemon-reload
