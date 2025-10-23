#!/usr/bin/env bash
set -euo pipefail

# Ensure Walker dependencies are running (reuse Omarchy helper expectations)
if ! pgrep -x elephant >/dev/null; then
  setsid uwsm-app -- elephant &
fi

if ! pgrep -f "walker --gapplication-service" >/dev/null; then
  setsid uwsm-app -- walker --gapplication-service &
fi

clients_json=$(hyprctl clients -j)

if [[ -z "$clients_json" ]]; then
  exit 0
fi

active_addr=$(hyprctl activewindow -j | jq -r '.address // empty')

options=$(printf '%s' "$clients_json" | jq -r --arg active "$active_addr" '
  map(select(.mapped == true)) |
  sort_by(.workspace.id, .at[0], .at[1]) |
  map([
    .address,
    (if .workspace.id == -1 then "special" else (.workspace.id|tostring) end),
    (.workspace.id|tostring),
    (.class // "?"),
    (.title // "Untitled"),
    (if .address == $active then "1" else "0" end)
  ]) |
  .[] |
  @tsv
')

if [[ -z "$options" ]]; then
  exit 0
fi

build_icon() {
  local class=${1,,}
  case "$class" in
    firefox|zen-browser|chromium|google-chrome) printf '';;
    code|codium|code-oss|vscode|vscodium) printf '';;
    alacritty|kitty|ghostty|wezterm|foot|termite|konsole|gnome-terminal) printf '';;
    spotify) printf '';;
    slack|discord|signal|whatsapp|element) printf '';;
    obsidian) printf '';;
    nautilus|dolphin|thunar|pcmanfm|nemo) printf '';;
    steam) printf '';;
    zed) printf '';;
    *) printf '';;
  esac
}

formatted_choices=""
while IFS=$'\t' read -r address workspace_label workspace_raw class title is_active; do
  [[ -z "$address" ]] && continue
  icon=$(build_icon "$class")
  indicator=" "
  [[ "$is_active" == "1" ]] && indicator="›"
  display_ws=$workspace_label
  [[ "$workspace_label" == "special" ]] && display_ws="Special"
  line="$icon $indicator WS $display_ws  $class — $title"
  formatted_choices+="${line}\t${address}\t${workspace_label}\n"
done <<< "$options"

if [[ -z "$formatted_choices" ]]; then
  exit 0
fi

selection=$(printf '%b' "$formatted_choices" | walker --dmenu --width 644 --maxheight 400 --minheight 300 --theme omarchy-default --placeholder "Switch window")

if [[ -z "$selection" ]]; then
  exit 0
fi

IFS=$'\t' read -r _display address workspace_label <<< "$selection"

if [[ -n "$address" ]]; then
  hyprctl dispatch focuswindow "address:$address"
  if [[ -n "$workspace_label" ]]; then
    label="$workspace_label"
    if [[ "$workspace_label" == "-1" || "$workspace_label" == "special" ]]; then
      label="special"
    fi
    notify-send --app-name WorkspaceOSD --expire-time=1500 --hint string:x-dunst-stack-tag:workspace "Workspace ${label}"
  fi
fi
