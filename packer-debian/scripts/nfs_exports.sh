#!/bin/bash
echo "setup NFS exports"

apt-get -y install nfs-kernel-server

cat > /etc/exports <<EOF
/vol/img 169.254.0.0/16(rw,sync,no_subtree_check,no_root_squash)
/vol/img 192.168.62.0/23(ro,sync,no_subtree_check)
/vol/music 169.254.0.0/16(ro,sync,no_subtree_check)
/vol/music 192.168.62.0/23(ro,sync,no_subtree_check)
/vol 169.254.0.0/16(ro,sync,fsid=0,no_subtree_check)
/vol/pub 169.254.0.0/16(rw,sync,no_subtree_check,no_root_squash)
/vol/pub 192.168.62.0/23(rw,sync,no_subtree_check,no_root_squash)
/vol/torrent 169.254.0.0/16(rw,sync,no_subtree_check)
/vol/torrent 192.168.62.0/23(ro,sync,no_subtree_check)
/vol/video 169.254.0.0/16(ro,sync,no_subtree_check)
/vol/video 192.168.62.0/23(ro,sync,no_subtree_check)
EOF
