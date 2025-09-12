#!/bin/bash

set -oue pipefail

trap '[[ $BASH_COMMAND != echo* ]] && [[ $BASH_COMMAND != log* ]] && echo "+ $BASH_COMMAND"' DEBUG

log() {
  echo "=== $* ==="
}

log "Enable systemd services"
systemctl enable nfs-server.service
systemctl enable sshd.service
systemctl enable zfs-scrub-monthly@storage.timer

log "Allow NFS with selinux and firewalld"
setsebool -P nfs_export_all_rw 1
firewall-cmd --permanent --zone=FedoraServer --add-service=nfs

log "Done managing services"
