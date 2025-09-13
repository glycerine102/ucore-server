#!/bin/bash

set -oue pipefail

trap '[[ $BASH_COMMAND != echo* ]] && [[ $BASH_COMMAND != log* ]] && echo "+ $BASH_COMMAND"' DEBUG

log() {
  echo "=== $* ==="
}

log "Ensure directories exist"
mkdir -p /var/lib/alternatives
mkdir /etc/netbird

log "Load ZFS modules"
echo zfs > /etc/modules-load.d/zfs.conf

log "Done managing files"
