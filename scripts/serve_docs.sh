#!/usr/bin/env bash
set -euo pipefail

HOST="${HOST:-127.0.0.1}"
PORT="${PORT:-8080}"
REPO_DIR="${REPO_DIR:-/home/jdlee/repos/sgt}"
SITE_DIR="${SITE_DIR:-/home/jdlee/repos/sgt/site}"

ENABLE_INTERNET=0

usage() {
  cat <<USAGE
Usage: $(basename "$0") [--internet]

Options:
  --internet   Bind to 0.0.0.0 so docs are reachable over the network/internet.
USAGE
}

for arg in "$@"; do
  case "$arg" in
    --internet)
      ENABLE_INTERNET=1
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      echo "Unknown argument: $arg" >&2
      usage >&2
      exit 1
      ;;
  esac
done

if [[ ! -d "$REPO_DIR" ]]; then
  echo "Repo directory not found: $REPO_DIR" >&2
  exit 1
fi

if [[ "$ENABLE_INTERNET" -eq 1 ]]; then
  HOST="0.0.0.0"
fi

cd "$REPO_DIR"

if ! python3 -c "import mkdocs" >/dev/null 2>&1; then
  python3 -m pip install -r docs/requirements.txt
fi

echo "Building docs into: $SITE_DIR"
mkdocs build --clean --site-dir "$SITE_DIR"

cd "$SITE_DIR"

echo "Serving rendered docs from: $SITE_DIR"
echo "Listening on: http://${HOST}:${PORT}/"
if [[ "$ENABLE_INTERNET" -eq 1 ]]; then
  echo "Internet mode enabled (--internet). Ensure firewall/NAT allows port ${PORT}."
fi

exec python3 -m http.server "$PORT" --bind "$HOST"
