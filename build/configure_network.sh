#!/bin/bash

set -oue pipefail

trap '[[ $BASH_COMMAND != echo* ]] && [[ $BASH_COMMAND != log* ]] && echo "+ $BASH_COMMAND"' DEBUG

log() {
  echo "=== $* ==="
}

log "Configure firewall rules"
firewall-cmd --permanent --zone=public --add-port=5201/tcp
firewall-cmd --reload

log "Done configuring network"
