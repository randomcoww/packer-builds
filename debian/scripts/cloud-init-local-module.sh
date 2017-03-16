## this allows systemd-networkd to be configured through write-file by running calling cloud-init init
## in cloud-init-local.service before network comes up
## should be removed for regular use
mkdir -p /etc/systemd/system/cloud-init-local.service.d
cat > /etc/systemd/system/cloud-init-local.service.d/init_local_module.conf <<EOF
[Service]
ExecStart=/usr/bin/cloud-init init
EOF
