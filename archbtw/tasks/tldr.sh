#!/usr/bin/env bash
# description: Install tealdeer and update tldr cache
set -euo pipefail

if ! pacman -Qi tealdeer &>/dev/null; then
  sudo pacman -S --needed --noconfirm tealdeer
else
  printf 'Skipping tealdeer (already installed)\n'
fi

tldr --update
