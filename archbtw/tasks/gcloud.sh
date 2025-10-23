#!/usr/bin/env bash
# description: Install Google Cloud CLI from official repositories
set -euo pipefail

if ! pacman -Qi google-cloud-cli &>/dev/null; then
  sudo pacman -S --needed --noconfirm google-cloud-cli
else
  printf 'Skipping google-cloud-cli (already installed)\n'
fi
