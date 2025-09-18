#!/bin/bash

set -oue pipefail

trap '[[ $BASH_COMMAND != echo* ]] && [[ $BASH_COMMAND != log* ]] && echo "+ $BASH_COMMAND"' DEBUG

log() {
  echo "=== $* ==="
}

log "Begin installing packages"

system_packages=(
  "htop"
  "lnav"
  "mbuffer"
)

devops_packages=(
  "cargo"
  "neovim"
  "rust"
)

networking_packages=(
  "netcat"
)

packages=(
  "${system_packages[@]}"
  "${devops_packages[@]}"
  "${networking_packages[@]}"
)

dnf5 install -y "${packages[@]}"

log "Done installing packages"
