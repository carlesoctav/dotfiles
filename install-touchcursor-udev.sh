#!/usr/bin/env bash
set -euo pipefail

RULE_SRC="$(realpath "$(dirname "${BASH_SOURCE[0]}")")/etc/udev/rules.d/00-touchcursor.rules"
RULE_DEST="/etc/udev/rules.d/00-touchcursor.rules"
SCRIPT_SRC="$(realpath "$(dirname "${BASH_SOURCE[0]}")")/etc/udev/touchcursor-reload.sh"
SCRIPT_DEST="/etc/udev/touchcursor-reload.sh"

if [[ ! -f "${RULE_SRC}" ]]; then
  echo "touchcursor udev rule not found at ${RULE_SRC}" >&2
  exit 1
fi

echo "Installing touchcursor udev rule to ${RULE_DEST}"
sudo install -Dm0644 "${RULE_SRC}" "${RULE_DEST}"

if [[ -f "${SCRIPT_SRC}" ]]; then
  echo "Installing touchcursor reload helper to ${SCRIPT_DEST}"
  sudo install -Dm0755 "${SCRIPT_SRC}" "${SCRIPT_DEST}"
else
  echo "WARNING: ${SCRIPT_SRC} not found; rule helper not installed." >&2
fi

echo "Reloading udev rules"
sudo udevadm control --reload

echo "Triggering keyboard add events so touchcursor reloads now"
sudo udevadm trigger --subsystem-match=input --action=add

if systemctl --user --quiet is-active touchcursor.service; then
  echo "Restarting touchcursor.service for good measure"
  systemctl --user restart touchcursor.service
fi

echo "Done."
