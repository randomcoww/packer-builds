#!/bin/sh
echo "install kubernetes components"

wget -O /usr/local/bin/kubelet https://storage.googleapis.com/kubernetes-release/release/v"$KUBERNETES_VERSION"/bin/linux/amd64/kubelet
chmod +x /usr/local/bin/kubelet

## kubelet systemd
mkdir -p /etc/kubernetes/manifests
cat > /etc/systemd/system/kubelet.service <<EOF
[Unit]
Description = Kubelet

[Service]
Restart = always
RestartSec = 5
ExecStart = /usr/local/bin/kubelet --pod-manifest-path=/etc/kubernetes/manifests --allow-privileged=true --register-schedulable=false

[Install]
WantedBy = multi-user.target
EOF
