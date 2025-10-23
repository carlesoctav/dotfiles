#!/usr/bin/env bash
# description: Install tmux, stow, neovim, and uv (legacy batch installer)
set -euo pipefail

"$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/tmux.sh"
"$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/stow.sh"
"$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/nvim.sh"
"$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/python.sh"
