#!/bin/bash

set -oue pipefail

trap '[[ $BASH_COMMAND != echo* ]] && [[ $BASH_COMMAND != log* ]] && echo "+ $BASH_COMMAND"' DEBUG

log() {
  echo "=== $* ==="
}

log "Ensure directories exist"
mkdir -p /var/lib/alternatives

log "Load ZFS modules"
echo zfs > /etc/modules-load.d/zfs.conf

log "Ensure the Alacritty terminal info is set up"
curl -s -L 'https://raw.githubusercontent.com/alacritty/alacritty/master/extra/alacritty.info' >alacritty.info
tic -xe alacritty,alacritty-direct alacritty.info && rm alacritty.info

log "Done managing files"
