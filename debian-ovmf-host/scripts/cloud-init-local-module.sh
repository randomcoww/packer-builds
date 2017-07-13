## allow cloud-init init (non local) to run from no-cloud before network is up
## for environments where this is desirable
mkdir -p /var/lib/cloud/seed/nocloud-net

mkdir -p /etc/systemd/system/cloud-init.service.d
cat > /etc/systemd/system/cloud-init.service.d/dropin.conf <<EOF
[Unit]
Wants=
Wants=network-pre.target
After=
After=cloud-init-local.service
Before=
Before=NetworkManager.service
Before=network-pre.target
Before=shutdown.target
Before=sysinit.target
RequiresMountsFor=/var/lib/cloud
EOF
