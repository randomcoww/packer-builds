#!/bin/sh
echo "install docker network overlay components"

## etcd
# wget -O /tmp/etcd.tar.gz https://github.com/coreos/etcd/releases/download/v$ETCD_VERSION/etcd-v$ETCD_VERSION-linux-amd64.tar.gz && \
# tar xzf /tmp/etcd.tar.gz --wildcards --strip-components=1 -C /usr/local/bin */etcdctl */etcd && \
# rm /tmp/etcd.tar.gz

## flannel
# wget -O /tmp/flannel.tar.gz https://github.com/coreos/flannel/releases/download/v$FLANNEL_VERSION/flannel-v$FLANNEL_VERSION-linux-amd64.tar.gz && \
# tar xzf /tmp/flannel.tar.gz -C /usr/local/bin 'flanneld' && \
# rm /tmp/flannel.tar.gz

## cni plugins
# wget -O /tmp/cni-plugins.tar.gz https://github.com/containernetworking/plugins/releases/download/v0.6.0/cni-plugins-amd64-v0.6.0.tgz && \
# mkdir -p /opt/cni/bin/ && tar xzf /tmp/cni-plugins.tar.gz -C /opt/cni/bin && \
# rm /tmp/cni-plugins.tar.gz

# apt-get update -y
# apt-get install -y --no-install-recommends etcd flannel
#
# systemctl disable flannel.service
# systemctl disable etcd.service
