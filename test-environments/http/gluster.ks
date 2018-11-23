install
skipx
lang en_US.UTF-8
keyboard us
timezone --utc Etc/UTC
auth --useshadow --passalgo=sha512
firewall --disabled
zerombr
clearpart --all --disklabel=gpt
autopart 
rootpw --lock --iscrypted locked
network --hostname=test
shutdown
bootloader --append="elevator=noop"

repo --name=fedora --mirrorlist=https://mirrors.fedoraproject.org/mirrorlist?repo=fedora-$releasever&arch=$basearch
repo --name=updates --mirrorlist=https://mirrors.fedoraproject.org/mirrorlist?repo=updates-released-f$releasever&arch=$basearch
url --mirrorlist=https://mirrors.fedoraproject.org/mirrorlist?repo=fedora-$releasever&arch=$basearch

%packages --excludeWeakdeps
@core

cronie
chrony
logrotate
nfs-utils

tmux
pciutils
rsync
vim-enhanced
nmap
unzip
bind-utils
openssl
shadow-utils
glusterfs
%end

%post --erroronfail

##
## serial autologin
##

mkdir -p /etc/systemd/system/serial-getty@.service.d
cat <<EOF > /etc/systemd/system/serial-getty@.service.d/autologin.conf
[Service]
ExecStart=
ExecStart=-/sbin/agetty -a root --keep-baud 115200,38400,9600 %I $TERM
EOF

##
## networkd
##

## enable systemd-resolve
ln -sf /run/systemd/resolve/resolv.conf /etc/resolv.conf

## write all configs
cat <<EOF > /etc/systemd/resolved.conf
[Resolve]
FallbackDNS=
DNSStubListener=no
EOF

cat <<EOF > /etc/systemd/network/98_dhcp.network
[Match]
Name=en*

[Network]
LinkLocalAddressing=no
DHCP=yes
EOF

##
## enable services
##

systemctl enable \
  systemd-networkd systemd-resolved chronyd crond

systemctl mask \
  NetworkManager

##
## cleanup
##

dnf -y autoremove
dnf -y clean all

rm -f /etc/machine-id
touch /etc/machine-id

%end

