#!/bin/bash

set -oue pipefail

trap '[[ $BASH_COMMAND != echo* ]] && [[ $BASH_COMMAND != log* ]] && echo "+ $BASH_COMMAND"' DEBUG

log() {
  echo "=== $* ==="
}

log "Install sanoid package"

SANOID_URL="https://raw.githubusercontent.com/jimsalterjrs/sanoid/refs/tags/v2.3.0"
TARGET_DIR="/usr/bin"
FILENAMES=("sanoid" "syncoid" "findoid")

# Loop over the filenames
for filename in "${FILENAMES[@]}"; do
    # Construct the full URL for each file
    full_url="${SANOID_URL}/${filename}"
    
    # Download the file using curl
    curl -s -o "${TARGET_DIR}/$filename" "$full_url" || { echo "Failed to download $full_url"; exit 1; }
    
    # Change file permissions
    chmod 0755 "${TARGET_DIR}/$filename" || { echo "Failed to set permissions for $filename"; exit 1; }
done


log "Begin installing packages"

system_packages=(
  "cargo"
  "htop"
  "lnav"
  "mbuffer"
  "neovim"
  "rust"
)

networking_packages=(
  "netbird"
  "netbird-ui"
)

packages=(
  "${system_packages[@]}"
  "${networking_packages[@]}"
)

dnf5 install -y "${packages[@]}"

log "Done installing packages"
