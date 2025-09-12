#!/bin/bash

set -oue pipefail

trap '[[ $BASH_COMMAND != echo* ]] && [[ $BASH_COMMAND != log* ]] && echo "+ $BASH_COMMAND"' DEBUG

log() {
  echo "=== $* ==="
}

log "Begin removing packages"

system_packages=(
  "docker-ce"
  "docker-ce-cli"
  "docker-buildx-plugin"
  "docker-compose-plugin"
  "docker-ce-rootless-extras"
  "tailscale"
)

packages=(
  "${system_packages[@]}"
)

dnf5 remove -y "${packages[@]}"

log "Done removing packages"
