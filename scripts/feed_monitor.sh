#!/usr/bin/env bash
set -euo pipefail

REPO_DIR="/home/jdlee/repos/feed-monitor"
APP="$REPO_DIR/dashboard/shm_dash_app.py"

if [[ ! -f "$APP" ]]; then
  echo "Dash app not found: $APP" >&2
  exit 1
fi

DEFAULT_REFDATA="$(ls -1t /home/jdlee/workspace/refdata/crypto_symbology/refdata.*.json 2>/dev/null | head -n 1 || true)"

SHM_PATHNAME="${SHM_PATHNAME:-/node_data/shm/datashm}"
HOST="${DASH_HOST:-127.0.0.1}"
PORT="${DASH_PORT:-8060}"
SLEEP_MS="${DASH_SLEEP_MS:-1}"
WINDOW_SEC="${DASH_WINDOW_SEC:-60}"
RETENTION_SEC="${DASH_RETENTION_SEC:-600}"
TITLE="${DASH_TITLE:-Price Monitor}"
REFDATA_FILE="${REFDATA_FILE:-$DEFAULT_REFDATA}"

CMD=(python3 "$APP" --pathname "$SHM_PATHNAME" --host "$HOST" --port "$PORT" --sleep-ms "$SLEEP_MS" --window-sec "$WINDOW_SEC" --retention-sec "$RETENTION_SEC" --title "$TITLE")
if [[ -n "$REFDATA_FILE" ]]; then
  CMD+=(--refdata "$REFDATA_FILE")
fi

exec "${CMD[@]}" "$@"
