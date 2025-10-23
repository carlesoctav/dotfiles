#!/usr/bin/env bash
# Helper invoked by udev to send HUP to the touchcursor process and log the event.

set -euo pipefail

USER_NAME="${1:-carlesoctav}"
TOUCHCURSOR_BIN="${2:-/usr/bin/touchcursor}"
LOGGER_BIN="/usr/bin/logger"
PKILL_BIN="/usr/bin/pkill"

# Minimal PATH for udev context
export PATH="/usr/bin:/bin"

log() {
  if [[ -x "${LOGGER_BIN}" ]]; then
    "${LOGGER_BIN}" -t touchcursor-udev "$*"
  fi
}

if ! id "${USER_NAME}" &>/dev/null; then
  log "user '${USER_NAME}' not found; skip reload"
  exit 0
fi

if [[ ! -x "${PKILL_BIN}" ]]; then
  log "pkill not available at ${PKILL_BIN}; skip reload"
  exit 0
fi

# Send HUP to any matching touchcursor process owned by the target user.
if "${PKILL_BIN}" -HUP --uid "${USER_NAME}" --full "^${TOUCHCURSOR_BIN}$" 2>/dev/null; then
  log "reloaded touchcursor for user ${USER_NAME} (device ${DEVNAME:-unknown})"
else
  log "no touchcursor process matched for user ${USER_NAME}"
fi

exit 0
