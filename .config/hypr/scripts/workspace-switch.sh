#!/usr/bin/env bash
set -euo pipefail

if [[ $# -lt 1 ]]; then
  exit 1
fi

workspace="$1"

hyprctl dispatch workspace "$workspace"

# Show notification (centered, non-stacking)
notify-send -t 1500 -a "WorkspaceOSD" -h string:x-canonical-private-synchronous:workspace "Workspace $workspace"
