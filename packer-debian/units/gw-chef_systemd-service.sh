cat > /etc/systemd/system/chef_systemd.service <<EOF
[Unit]
Description=chef_systemd
After=etc-chef.mount

[Service]
TimeoutStartSec=0
Restart=on-failure
RestartSec=20
ExecStartPre=/usr/bin/chef-client -c /etc/chef/client.rb -o 'role[systemd_units_gw]'
ExecStart=/usr/bin/chef-client -c /etc/chef/client.rb -i 300 -s 30 -o 'role[systemd_units_gw]'

[Install]
WantedBy=multi-user.target
EOF
systemctl enable chef_systemd.service
