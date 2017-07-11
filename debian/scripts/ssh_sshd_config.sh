#!/bin/sh
echo "configure key only SSH"

cat > /etc/ssh/sshd_config <<EOF
Subsystem sftp internal-sftp

PermitRootLogin no
PasswordAuthentication no
ChallengeResponseAuthentication no
EOF
