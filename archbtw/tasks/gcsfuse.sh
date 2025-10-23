#!/usr/bin/env bash
# description: Install gcsfuse (requires yay or paru for AUR packages)
set -euo pipefail

if command -v gcsfuse &>/dev/null; then
  printf 'Skipping gcsfuse (already installed)\n'
  exit 0
fi

aur_helper=""
if command -v yay &>/dev/null; then
  aur_helper="yay"
elif command -v paru &>/dev/null; then
  aur_helper="paru"
fi

if [[ -z "${aur_helper}" ]]; then
  printf 'Error: gcsfuse is not in the official repositories. Install yay or paru first.\n' >&2
  exit 1
fi

"${aur_helper}" -S --needed gcsfuse-bin
