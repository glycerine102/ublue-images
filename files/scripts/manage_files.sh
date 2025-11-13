#!/usr/bin/env bash

set -oue pipefail

trap '[[ $BASH_COMMAND != echo* ]] && [[ $BASH_COMMAND != log* ]] && echo "+ $BASH_COMMAND"' DEBUG

log() {
  echo "=== $* ==="
}

log "Ensure directories exist"
mkdir -p /var/lib/alternatives
mkdir -p /var/log/netbird

log "Use different config file for netbird"
sed -i 's/config\.json/default\.json/g' /usr/lib/systemd/system/netbird.service

log "Done managing files"
