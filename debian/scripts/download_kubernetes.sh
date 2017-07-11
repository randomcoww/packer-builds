#!/bin/sh
echo "download kubernetes components"

wget -O /usr/local/bin/kubelet https://storage.googleapis.com/kubernetes-release/release/v$KUBERNETES_VERSION/bin/linux/amd64/kubelet
wget -O /usr/local/bin/kube-proxy https://storage.googleapis.com/kubernetes-release/release/v$KUBERNETES_VERSION/bin/linux/amd64/kube-proxy

chmod +x /usr/local/bin/kubelet /usr/local/bin/kube-proxy
