#!/usr/bin/env bash
# description: Install rustup and set stable toolchain as default
set -euo pipefail

if ! pacman -Qi rustup &>/dev/null; then
  sudo pacman -S --needed --noconfirm rustup
else
  printf 'Skipping rustup install (already installed)\n'
fi

if command -v rustup &>/dev/null; then
  rustup install stable
  rustup default stable
else
  echo "rustup command not found in PATH; log out/in and rerun this script to configure toolchain."
fi
