#!/bin/sh
echo "install docker"

apt-get -y install apt-transport-https ca-certificates gnupg2 dirmngr
apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
echo deb https://apt.dockerproject.org/repo debian-stretch main > /etc/apt/sources.list.d/docker.list
apt-get -y update
## key fetch frequently fails and breaks the build. add --allow-unauthenticated for convenience
apt-get -y --allow-unauthenticated install docker-engine

systemctl stop docker
systemctl disable docker
