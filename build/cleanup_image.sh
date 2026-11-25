#!/usr/bin/bash
set -euo pipefail

trap '[[ $BASH_COMMAND != echo* ]] && [[ $BASH_COMMAND != log* ]] && echo "+ $BASH_COMMAND"' DEBUG

log() {
  echo "=== $* ==="
}

log "Starting system cleanup"

# Clean package manager cache
dnf5 clean all

# Clean temporary files
rm -rf /tmp/*

# Clean /var directory while preserving essential files
find /var/* -maxdepth 0 -type d \
    ! -name cache \
    ! -name log \
    -exec rm -rf -- {} +

find /var/cache/* -maxdepth 0 -type d \
    ! -name libdnf5 \
    ! -name rpm-ostree \
    -exec rm -rf -- {} +

# Restore and setup directories
mkdir -p /var/tmp
chmod -R 1777 /var/tmp

log "Cleanup completed"
