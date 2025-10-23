#!/usr/bin/env bash
# description: Install Zig compiler via pacman
set -euo pipefail

if ! pacman -Qi zig &>/dev/null; then
  sudo pacman -S --needed --noconfirm zig
else
  printf 'Skipping zig (already installed)\n'
fi
