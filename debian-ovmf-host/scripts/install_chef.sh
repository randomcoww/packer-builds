#!/bin/bash
echo "install Chef"

apt-get update -y
apt-get install -y --no-install-recommends wget ca-certificates
sh -c "wget -q -O - https://www.chef.io/chef/install.sh | bash"
apt-get clean
