#!/bin/sh
echo "install nftables and enable modules"

apt-get -y update
apt-get -y install nftables

cat >> /etc/initramfs-tools/modules <<EOF
nft_nat
nft_chain_nat_ipv4
nft_chain_nat_ipv6
EOF

update-initramfs -u
update-grub
