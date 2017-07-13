#!/bin/sh
echo "install qemu and enable modules"

apt-get -y update
apt-get -y install qemu-kvm libvirt-bin ovmf ksmtuned
apt-get clean

cat >> /etc/initramfs-tools/modules <<EOF
vfio
vfio_iommu_type1
vfio_pci
vfio_virqfd
EOF

#options vfio-pci ids=1002:ffffffff:ffffffff:ffffffff:00030000:ffff00ff,1002:ffffffff:ffffffff:ffffffff:00040300:ffffffff,10de:ffffffff:ffffffff:ffffffff:00030000:ffff00ff,10de:ffffffff:ffffffff:ffffffff:00040300:ffffffff
cat >> /etc/modprobe.d/vfio.conf <<EOF
options kvm ignore_msrs=1
options kvm-intel nested=1
EOF

update-initramfs -u
update-grub
