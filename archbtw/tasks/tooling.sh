#!/usr/bin/env bash
# description: Install common CLI tooling (fd, rg, gh, jq, bat, curlie, xsv, yq, fzf, unzip)
set -euo pipefail

packages=(
  fd
  ripgrep
  github-cli
  jq
  bat
  curlie
  xsv
  yq
  fzf
  unzip
)

sudo pacman -S --needed --noconfirm "${packages[@]}"

echo "dotenv-linter and aliasman require manual installation (not in official repos)."
