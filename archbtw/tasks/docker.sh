#!/usr/bin/env bash
# description: Install Docker, enable the service, and add current user to docker group
set -euo pipefail

if ! pacman -Qi docker &>/dev/null; then
  sudo pacman -S --needed --noconfirm docker
else
  printf 'Skipping docker (already installed)\n'
fi

sudo systemctl enable --now docker

if ! getent group docker &>/dev/null; then
  sudo groupadd docker
fi

if ! id -nG "${USER}" | grep -qw docker; then
  sudo usermod -aG docker "${USER}"
  printf 'Added %s to docker group. Log out/in to apply.\n' "${USER}"
else
  printf 'User %s already in docker group\n' "${USER}"
fi
