#!/usr/bin/env bash
# description: Clear caches, pacman package cache, and trim logs
set -euo pipefail

echo "=== Arch Storage Cleanup ==="

echo "Cleaning user cache..."
rm -rf "${HOME}/.cache"/* || true

echo "Cleaning temp directories..."
sudo rm -rf /tmp/* /var/tmp/* || true

echo "Cleaning pacman cache (requires sudo)..."
sudo pacman -Sc --noconfirm || true

echo "Cleaning journal logs (requires sudo)..."
sudo journalctl --vacuum-time=3d

if command -v docker &>/dev/null; then
  echo "Cleaning Docker..."
  docker system prune -a --volumes -f
fi

echo ""
echo "=== Cleanup Complete ==="
df -h /
du -sh "${HOME}" 2>/dev/null | cat
