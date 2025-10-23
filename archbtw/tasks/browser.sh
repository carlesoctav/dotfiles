#!/usr/bin/env bash
# description: Install Brave browser via Flatpak and expose a brave launcher
set -euo pipefail

if ! command -v flatpak &>/dev/null; then
  sudo pacman -S --needed --noconfirm flatpak
fi

sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
sudo flatpak install -y flathub com.brave.Browser

mkdir -p "${HOME}/.local/bin"
if [[ -x /var/lib/flatpak/exports/bin/com.brave.Browser ]]; then
  ln -sf /var/lib/flatpak/exports/bin/com.brave.Browser "${HOME}/.local/bin/brave"
elif [[ -x "${HOME}/.local/share/flatpak/exports/bin/com.brave.Browser" ]]; then
  ln -sf "${HOME}/.local/share/flatpak/exports/bin/com.brave.Browser" "${HOME}/.local/bin/brave"
fi

export BROWSER="${HOME}/.local/bin/brave"
printf 'Brave launcher available at %s (BROWSER exported for this session)\n' "${BROWSER}"
