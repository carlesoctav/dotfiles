#!/usr/bin/env bash
set -euo pipefail

if [[ $# -lt 1 ]]; then
  exit 1
fi

workspace="$1"

hyprctl dispatch workspace "$workspace"
notify-send --app-name WorkspaceOSD --expire-time=1500 --hint string:x-dunst-stack-tag:workspace "Workspace ${workspace}"
