cat > /etc/systemd/system/chef-client.service <<EOF
[Unit]
Description=chef-client
After=etc-chef.mount

[Service]
TimeoutStartSec=0
Restart=on-failure
RestartSec=20
ExecStart=/usr/bin/chef-client -c /etc/chef/client.rb -j /etc/chef/environment.json -i 1200 -s 60 -o 'role[$CHEF_ROLE]'

[Install]
WantedBy=multi-user.target
EOF
systemctl enable chef-client.service
