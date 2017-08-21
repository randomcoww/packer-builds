#!/bin/bash
echo "install laptop components"

## no gui
apt-get -y update
apt-get -y install firmware-realtek wpasupplicant nfs-common ipmitool
