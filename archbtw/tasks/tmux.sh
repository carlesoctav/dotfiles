#!/usr/bin/env bash
# description: Install tmux via pacman and bootstrap TPM plugin manager
set -euo pipefail

if ! pacman -Qi tmux &>/dev/null; then
  sudo pacman -S --needed --noconfirm tmux
else
  printf 'Skipping tmux (already installed)\n'
fi

if [[ ! -d "${HOME}/.tmux/plugins/tpm" ]]; then
  git clone https://github.com/tmux-plugins/tpm "${HOME}/.tmux/plugins/tpm"
else
  printf 'Skipping TPM clone (already present)\n'
fi
