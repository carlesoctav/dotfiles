#!/usr/bin/env bash
# description: Install uv (Python toolchain) via Astral installer
set -euo pipefail

if command -v uv &>/dev/null; then
  printf 'Skipping uv (already installed)\n'
  exit 0
fi

curl -LsSf https://astral.sh/uv/install.sh | sh
