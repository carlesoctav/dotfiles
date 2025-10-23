#!/usr/bin/env bash
# description: Install Atlassian CLI via pipx
set -euo pipefail

if ! pacman -Qi python-pipx &>/dev/null; then
  sudo pacman -S --needed --noconfirm python-pipx
fi

pipx install --include-deps atlassian-cli || pipx reinstall atlassian-cli
