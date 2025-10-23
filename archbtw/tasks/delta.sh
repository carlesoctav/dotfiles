#!/usr/bin/env bash
# description: Install git-delta from the official repositories
set -euo pipefail

if ! pacman -Qi git-delta &>/dev/null; then
  sudo pacman -S --needed --noconfirm git-delta
else
  printf 'Skipping git-delta (already installed)\n'
fi
