#!/usr/bin/env bash
# description: Install Quarto CLI
set -euo pipefail

if ! pacman -Qi quarto-cli &>/dev/null; then
  sudo pacman -S --needed --noconfirm quarto-cli
else
  printf 'Skipping quarto-cli (already installed)\n'
fi
