#!/usr/bin/env bash
# description: Install matugen (material color generation tool)
set -euo pipefail

if ! command -v cargo &>/dev/null; then
  printf 'cargo is required. Run rust.sh first.\n' >&2
  exit 1
fi

cargo install matugen
printf 'matugen installed successfully\n'
