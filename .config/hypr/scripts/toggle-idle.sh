#!/bin/bash
STATE_FILE="/tmp/hypridle_inhibited"

if [ -f "$STATE_FILE" ]; then
    rm "$STATE_FILE"
    hypridle &
else
    touch "$STATE_FILE"
    pkill -x hypridle
fi