#!/bin/bash
STATE_FILE="/tmp/hypridle_inhibited"

if [ -f "$STATE_FILE" ]; then
    printf "☀️"
else
    printf "🌙"
fi