#!/bin/bash

set -ouex pipefail

# Add custom just files
echo "import \"/usr/share/ublue-os/just/95-cordelia.just\"" >> /usr/share/ublue-os/justfile
