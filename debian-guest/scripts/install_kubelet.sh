#!/bin/sh
echo "install kubelet minimal config"

## kubelet
wget -O /usr/local/bin/kubelet https://storage.googleapis.com/kubernetes-release/release/v$KUBERNETES_VERSION/bin/linux/amd64/kubelet && \
chmod +x /usr/local/bin/kubelet

## kube-proxy
wget -O /usr/local/bin/kube-proxy https://storage.googleapis.com/kubernetes-release/release/v$KUBERNETES_VERSION/bin/linux/amd64/kube-proxy && \
chmod +x /usr/local/bin/kube-proxy

## etcd
wget -O /tmp/etcd.tar.gz https://github.com/coreos/etcd/releases/download/v$ETCD_VERSION/etcd-v$ETCD_VERSION-linux-amd64.tar.gz && \
tar xzf /tmp/etcd.tar.gz --wildcards --strip-components=1 -C /usr/local/bin */etcdctl */etcd && \
rm /tmp/etcd.tar.gz

## flannel
wget -O /tmp/flannel.tar.gz https://github.com/coreos/flannel/releases/download/v$FLANNEL_VERSION/flannel-v$FLANNEL_VERSION-linux-amd64.tar.gz && \
tar xzf /tmp/flannel.tar.gz -C /usr/local/bin 'flanneld' && \
rm /tmp/flannel.tar.gz

## cni plugins
wget -O /tmp/cni-plugins.tar.gz https://github.com/containernetworking/plugins/releases/download/v$CNI_PLUGIN_VERSION/cni-plugins-amd64-v$CNI_PLUGIN_VERSION.tgz && \
mkdir -p /opt/cni/bin/ && tar xzf /tmp/cni-plugins.tar.gz -C /opt/cni/bin && \
rm /tmp/cni-plugins.tar.gz


## kubelet systemd
mkdir -p /etc/kubernetes/manifests
cat > /etc/systemd/system/kubelet.service <<EOF
[Unit]
Description = Kubelet

[Service]
Restart = always
RestartSec = 5
ExecStart = /usr/local/bin/kubelet --pod-manifest-path=/etc/kubernetes/manifests --allow-privileged=true

[Install]
WantedBy = multi-user.target
EOF

# systemctl enable kubelet.service
