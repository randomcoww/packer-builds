#!/bin/sh
echo "install kubernetes components"

wget -O /usr/local/bin/kubelet $KUBELET_URL
chmod +x /usr/local/bin/kubelet

wget -O /usr/local/bin/kube-proxy $KUBE_PROXY_URL
chmod +x /usr/local/bin/kube-proxy

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
