#!/usr/bin/env bash
# description: Install Go toolchain via pacman
set -euo pipefail

if ! pacman -Qi go &>/dev/null; then
  sudo pacman -S --needed --noconfirm go
else
  printf 'Skipping go (already installed)\n'
fi
