#!/usr/bin/env bash
# description: Install GNU Stow via pacman
set -euo pipefail

if ! pacman -Qi stow &>/dev/null; then
  sudo pacman -S --needed --noconfirm stow
else
  printf 'Skipping stow (already installed)\n'
fi
