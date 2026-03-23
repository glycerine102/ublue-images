#!/bin/bash

set -oue pipefail

trap '[[ $BASH_COMMAND != echo* ]] && [[ $BASH_COMMAND != log* ]] && echo "+ $BASH_COMMAND"' DEBUG

log() {
  echo "=== $* ==="
}

log "Install netbird package"

NETBIRD_VERSION="0.66.4"

rpm -ivh --noscripts https://github.com/netbirdio/netbird/releases/download/v${NETBIRD_VERSION}/netbird_${NETBIRD_VERSION}_linux_amd64.rpm
rpm -ivh --noscripts https://github.com/netbirdio/netbird/releases/download/v${NETBIRD_VERSION}/netbird-ui_${NETBIRD_VERSION}_linux_amd64.rpm

log "Done installing packages"

log "Ensure directories exist"

mkdir -p /var/log/netbird
mkdir -p /var/run/netbird

log "Done creating directories"
