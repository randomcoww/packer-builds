#!/bin/sh

cat >> /etc/default/grub <<EOF
GRUB_TERMINAL="console serial"
GRUB_SERIAL_COMMAND="serial --unit=1 --speed=115200 --word=8 --parity=no --stop=1"
EOF
