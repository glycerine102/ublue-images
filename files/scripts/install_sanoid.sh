#!/bin/bash

set -oue pipefail

trap '[[ $BASH_COMMAND != echo* ]] && [[ $BASH_COMMAND != log* ]] && echo "+ $BASH_COMMAND"' DEBUG

log() {
  echo "=== $* ==="
}

log "Install sanoid package"

SANOID_URL="https://github.com/decoyjoe/sanoid-portable/releases/download/2.3.0-1/sanoid-portable"
SANOID_DIR="/usr/bin"

wget ${SANOID_URL} -O ${SANOID_DIR}/sanoid-portable
chmod +x ${SANOID_DIR}/sanoid-portable
sh ${SANOID_DIR}/sanoid-portable --assimilate
ln -s ${SANOID_DIR}/sanoid-portable /usr/bin/sanoid
ln -s ${SANOID_DIR}/sanoid-portable /usr/bin/syncoid
ln -s ${SANOID_DIR}/sanoid-portable /usr/bin/findoid

log "Done installing packages"
