#!/usr/bin/env bash
set -euo pipefail

if [[ $# -lt 1 ]]; then
  exit 1
fi

workspace="$1"

hyprctl dispatch movetoworkspace "$workspace"
hyprctl dispatch workspace "$workspace"
# Notification handled by quickshell bar
