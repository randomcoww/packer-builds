#!/bin/bash
echo "install desktop components"

## non free
echo deb http://httpredir.debian.org/debian/ stretch main contrib non-free >> /etc/apt/sources.list

## chrome
# echo deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main > /etc/apt/sources.list.d/google-chrome.list
# apt-key adv --fetch-keys https://dl.google.com/linux/linux_signing_key.pub | apt-key add -

apt-get -y update
# apt-get -y install firmware-iwlwifi wpasupplicant atom terminix mpv ncmpcpp youtube-dl google-chrome-stable
apt-get -y install firmware-iwlwifi wpasupplicant nfs-common

## packer
wget -O /tmp/packer.zip https://releases.hashicorp.com/packer/1.0.3/packer_1.0.3_linux_amd64.zip
unzip /tmp/packer.zip -d /usr/local/bin
rm /tmp/packer.zip

## chefdk
wget -O /tmp/chefdk.deb https://packages.chef.io/files/stable/chefdk/2.0.28/debian/8/chefdk_2.0.28-1_amd64.deb
dpkg -i /tmp/chefdk.deb
rm /tmp/chefdk.deb
