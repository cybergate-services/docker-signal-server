#!/bin/bash
set -euo pipefail
for patch in /tmp/signal-server-patches/*.patch; do
  echo "patch -p1 < \$patch"
  patch -p1 < $patch
done
