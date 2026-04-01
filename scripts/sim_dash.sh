#!/usr/bin/env bash
set -euo pipefail

REPO_DIR="/home/jdlee/repos/trading-ui/sim_dashboard"
APP="$REPO_DIR/app.py"

if [[ ! -f "$APP" ]]; then
  echo "Dash app not found: $APP" >&2
  exit 1
fi

HOST="${DASH_HOST:-127.0.0.1}"
PORT="${DASH_PORT:-8070}"
DEBUG="${DASH_DEBUG:-1}"
PYTHON_BIN="${PYTHON_BIN:-python3}"

cd "$REPO_DIR"

CMD=("$PYTHON_BIN" "$APP")
exec env DASH_HOST="$HOST" DASH_PORT="$PORT" DASH_DEBUG="$DEBUG" "${CMD[@]}" "$@"
