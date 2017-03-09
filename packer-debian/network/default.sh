## LAN bridge

cat > /etc/systemd/network/default.network <<EOF
[Match]
Name=eth*

[Network]
LinkLocalAddressing=no
DHCP=yes
EOF
