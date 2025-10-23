#!/usr/bin/env bash
set -euo pipefail

packages=(
  lazygit
  # lazydocker
  obsidian
  signal-desktop
  obs-studio
  kdenlive
  1password-beta
  1password-cli
  typora
  dropbox
  tailscale
  spotify
  eza
  starship
  zoxide
)

for pkg in "${packages[@]}"; do
  if pacman -Qi "$pkg" &>/dev/null; then
    sudo pacman -Rns --noconfirm "$pkg"
  else
    printf 'Skipping %s (not installed)\n' "$pkg"
  fi
done
