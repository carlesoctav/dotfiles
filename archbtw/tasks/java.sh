#!/usr/bin/env bash
# description: Install OpenJDK runtime
set -euo pipefail

if ! pacman -Qi jre-openjdk &>/dev/null; then
  sudo pacman -S --needed --noconfirm jre-openjdk
else
  printf 'Skipping jre-openjdk (already installed)\n'
fi
