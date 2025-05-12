#!/usr/bin/env bash
# Remove the helper binaries that the preflight script dropped in /usr/local/bin
# Run with sudo.

set -euo pipefail

BIN_DIR="/usr/local/bin"

echo "➤ Removing Haveno helper files…"
rm -f  "$BIN_DIR/daemon.jar"
rm -f  "$BIN_DIR/monero-wallet-rpc"
rm -f  "$BIN_DIR/tor.zip"
rm -f  "$BIN_DIR/tor"                    # tor binary itself
rm -rf "$BIN_DIR/tor"*                  # directory if the zip unpacked that way

# Optionally remove the ‘unzip’ formula if it was installed only for Haveno
if brew list --formula | grep -q "^unzip$"; then
  # Ignore dependency graph; if some other package still needs unzip, this fails harmlessly
  brew uninstall --ignore-dependencies unzip || true
fi

echo "✓  Helper files removed."