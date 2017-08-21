#!/bin/bash
echo "install desktop components"

## chrome
# echo deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main > /etc/apt/sources.list.d/google-chrome.list
# apt-key adv --fetch-keys https://dl.google.com/linux/linux_signing_key.pub | apt-key add -

apt-get -y update
# apt-get -y install firmware-iwlwifi wpasupplicant atom terminix mpv ncmpcpp youtube-dl google-chrome-stable
apt-get -y install task-gnome-desktop
apt-get -y install firmware-iwlwifi wpasupplicant nfs-common ipmitool tilix mpv ncmpcpp youtube-dl cups xtightvncviewer

## packer
wget -O /tmp/packer.zip $PACKER_URL
unzip /tmp/packer.zip -d /usr/local/bin
rm /tmp/packer.zip

## chefdk
wget -O /tmp/chefdk.deb $CHEFDK_URL
dpkg -i /tmp/chefdk.deb
rm /tmp/chefdk.deb
