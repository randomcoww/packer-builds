#!/bin/sh
echo "install cloud-init"

apt-get update -y
apt-get -y install cloud-init net-tools

## add cloud config
## move bootcmd to after write-files
cat > /etc/cloud/cloud.cfg <<EOF
cloud_init_modules:
 - migrator
 - seed_random
 - write-files
 - bootcmd
 - growpart
 - resizefs
 - disk_setup
 - mounts
 - set_hostname
 - update_hostname
 - update_etc_hosts
 - ca-certs
 - rsyslog
 - users-groups
 - ssh

cloud_config_modules:
 - emit_upstart
 - ssh-import-id
 - locale
 - set-passwords
 - grub-dpkg
 - apt-pipelining
 - apt-configure
 - ntp
 - timezone
 - disable-ec2-metadata
 - runcmd
 - byobu

cloud_final_modules:
 - package-update-upgrade-install
 - fan
 - puppet
 - chef
 - salt-minion
 - mcollective
 - rightscale_userdata
 - scripts-vendor
 - scripts-per-once
 - scripts-per-boot
 - scripts-per-instance
 - scripts-user
 - ssh-authkey-fingerprints
 - keys-to-console
 - phone-home
 - final-message
 - power-state-change

system_info:
  paths:
    cloud_dir: /var/lib/cloud/
    templates_dir: /etc/cloud/templates/
EOF
