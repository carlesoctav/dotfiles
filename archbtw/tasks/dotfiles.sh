#!/usr/bin/env bash
# description: Install stow and fuse, back up existing bashrc
set -euo pipefail

sudo pacman -S --needed --noconfirm stow fuse3

if [[ -f "${HOME}/.bashrc" && ! -f "${HOME}/.bashrc.bak" ]]; then
  mv "${HOME}/.bashrc" "${HOME}/.bashrc.bak"
  printf 'Backed up ~/.bashrc to ~/.bashrc.bak\n'
else
  printf 'No ~/.bashrc backup needed (already backed up or missing)\n'
fi
