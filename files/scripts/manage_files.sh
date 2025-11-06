#!/usr/bin/env bash

set -oue pipefail

trap '[[ $BASH_COMMAND != echo* ]] && [[ $BASH_COMMAND != log* ]] && echo "+ $BASH_COMMAND"' DEBUG

log() {
  echo "=== $* ==="
}

log "Ensure directories exist"
mkdir -p /var/lib/alternatives
mkdir -p /var/log/netbird

log "Done managing files"
