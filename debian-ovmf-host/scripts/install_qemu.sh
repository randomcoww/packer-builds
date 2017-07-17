#!/bin/sh
echo "install qemu and enable modules"

apt-get -y update
apt-get -y install qemu-kvm libvirt-clients libvirt-daemon-system ovmf ksmtuned

cat >> /etc/initramfs-tools/modules <<EOF
vfio
vfio_iommu_type1
vfio_pci
vfio_virqfd
EOF

cat >> /etc/modprobe.d/vfio.conf <<EOF
options vfio-pci ids=1002:ffffffff:ffffffff:ffffffff:00030000:ffff00ff,1002:ffffffff:ffffffff:ffffffff:00040300:ffffffff,10de:ffffffff:ffffffff:ffffffff:00030000:ffff00ff,10de:ffffffff:ffffffff:ffffffff:00040300:ffffffff
options kvm ignore_msrs=1
options kvm-intel nested=1
EOF
