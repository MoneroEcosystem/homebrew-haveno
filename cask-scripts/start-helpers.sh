#!/usr/bin/env bash
set -euo pipefail
SELF_DIR="$(dirname "$0")"

# 1. launch Tor + daemon, capture PIDs
"$SELF_DIR/tor" -f "$SELF_DIR/../Resources/torrc" --quiet &
TOR_PID=$!
java -jar "$SELF_DIR/../Java/daemon.jar" &
JAR_PID=$!

# 2. when Flutter GUI exits, kill helpers
trap 'kill $JAR_PID $TOR_PID' EXIT INT TERM

# 3. exec the real Flutter binary
exec "$SELF_DIR/Haveno" "$@"