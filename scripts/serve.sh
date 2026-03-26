#!/usr/bin/env bash
set -euo pipefail

PORT="${PORT:-8080}"
HOST="${HOST:-127.0.0.1}"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPOS_ROOT="$(cd "${SCRIPT_DIR}/../.." && pwd)"
EM_DOCS_DIR="${REPOS_ROOT}/em/em-feature-documentation/docs"

if [ ! -d "${EM_DOCS_DIR}" ]; then
  echo "Error: docs directory not found at ${EM_DOCS_DIR}" >&2
  exit 1
fi

USER_NAME="${USER:-$(id -un)}"
USER_HASH="$(printf '%s' "${USER_NAME}" | sha256sum | awk '{print $1}')"
QR_ENABLED_USER_HASH="51264ad310558c6744c6e5a80463df6f9bb92edf1023b63f2a8da507e7b5d5fa"

SHOW_QR="false"
QR_DOCS_DIR="${REPOS_ROOT}/qr/qr-wsl/docs"
if [ "${USER_HASH}" = "${QR_ENABLED_USER_HASH}" ] && [ -d "${QR_DOCS_DIR}" ]; then
  SHOW_QR="true"
fi

if [ "${SHOW_QR}" = "true" ]; then
  SERVER_ROOT="${REPOS_ROOT}"
  DOC_ENTRY="/em/em-feature-documentation/docs/index.html"
else
  SERVER_ROOT="${EM_DOCS_DIR}"
  DOC_ENTRY="/index.html"
fi

cd "${SERVER_ROOT}"

if [ -n "${WSL_DISTRO_NAME:-}" ]; then
  WINDOWS_HOST=$(awk '/^nameserver /{print $2; exit}' /etc/resolv.conf 2>/dev/null || true)
else
  WINDOWS_HOST=""
fi

echo "Serving documentation from:"
echo " - ${SERVER_ROOT}"
echo "Available at:"
echo " - http://localhost:${PORT}${DOC_ENTRY} (recommended)"
echo " - http://${HOST}:${PORT}"
if [ -n "${WINDOWS_HOST}" ]; then
  echo " - http://${WINDOWS_HOST}:${PORT}${DOC_ENTRY}"
fi

exec python3 -m http.server "${PORT}" --bind "${HOST}"
