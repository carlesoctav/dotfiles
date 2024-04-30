#!/usr/bin/env bash
fuzzy_finder=fzf  # use either fzf or sk
with_context=$(printf "yes\nno" | fzf)
prompt=$(ls ~/.config/prompt | fzf) 
prompt_string=$(cat ~/.config/prompt/"$prompt")
read -p "Enter Query: " query

if ["$with_context"="yes"]; then
    tmux neww -n "$query" bash -c "chatsh chat -clipboard-context \"$query\" & while [ : ]; do sleep 1; done"
elif [ "$with_context"="no" ]; then
    tmux neww -n "$query" bash -c "chatsh chat -clipboard-context -prompt \"$prompt_string\" \"$query\" & while [ : ]; do sleep 1; done"
fi
