#!/usr/bin/env bash
# description: Run common bootstrap tasks (tmux, python, node, tooling, nvim)
set -euo pipefail

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

"${script_dir}/tmux.sh"
"${script_dir}/python.sh"
"${script_dir}/node.sh"
"${script_dir}/tooling.sh"
"${script_dir}/nvim.sh"
