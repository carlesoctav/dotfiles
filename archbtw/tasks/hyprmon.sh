#!/usr/bin/env bash
# description: Install hyprmon (Hyprland monitor manager) from repo or AUR
set -euo pipefail

if command -v hyprmon &>/dev/null || pacman -Qi hyprmon &>/dev/null; then
  printf 'Skipping hyprmon (already installed)\n'
  exit 0
fi

if pacman -Si hyprmon &>/dev/null; then
  sudo pacman -S --needed --noconfirm hyprmon
  exit 0
fi

aur_helper=""
if command -v yay &>/dev/null; then
  aur_helper="yay"
elif command -v paru &>/dev/null; then
  aur_helper="paru"
fi

if [[ -z "${aur_helper}" ]]; then
  printf 'Error: hyprmon is not in the official repositories. Install yay or paru first.\n' >&2
  exit 1
fi

aur_packages=(hyprmon hyprmon-bin hyprmon-git)
for package in "${aur_packages[@]}"; do
  if "${aur_helper}" -Si "${package}" &>/dev/null; then
    "${aur_helper}" -S --needed "${package}"
    exit 0
  fi
done

printf 'Error: Unable to locate hyprmon in the AUR (tried: %s)\n' "${aur_packages[*]}" >&2
exit 1
