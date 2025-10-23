#!/usr/bin/env bash
# description: Install Neovim via pacman
set -euo pipefail

if ! pacman -Qi neovim &>/dev/null; then
  sudo pacman -S --needed --noconfirm neovim
else
  printf 'Skipping neovim (already installed)\n'
fi
