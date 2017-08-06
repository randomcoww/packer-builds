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
options kvm ignore_msrs=1
options kvm-intel nested=1
options igb max_vfs=8
options ixgbe max_vfs=8
EOF
