## LAN bridge

cat > /etc/systemd/network/default.network <<EOF
[Match]
Name=eth*

[Network]
DHCP=yes
EOF
