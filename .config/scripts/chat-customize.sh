#!/usr/bin/env bash
#

# Prerequisites:
# - fuzzy finder: either fzf or sk
# - bat: as cat replacement - is being used as pager inside nvim terminal

fuzzy_finder=fzf  # use either fzf or sk

prompt= "ls ~/.config/prompt | fzf"
chatfile=".ls ./.cht/ | fzf"
includeClipboard= "true\n false | fzf"

nvim_options="\
    -c \"nnoremap i :echo 'i disabled!'<CR>\" \
    -c \"nnoremap I :echo 'I disabled!'<CR>\" \
    -c \"nnoremap a :echo 'a disabled!'<CR>\" \
    -c \"nnoremap A :echo 'A disabled!'<CR>\" \
    -c \"nnoremap p :echo 'p disabled!'<CR>\" \
    -c \"nnoremap P :echo 'P disabled!'<CR>\" \
    -c \"nnoremap q :q!<CR>\""

# Using bat inside the terminal results in line wraps to dynamically adjust
# when changing the windown size
bat_options="\
    --paging=always \
    --style=plain"


read -p "Enter Query: " query

if includeClipboard=="true"; then
    tmux neww -n "$query" bash -c "chatsh -chat-file \"$chatfile\" -prompt \"$prompt\" -clipboard-context chat \"$query\" & while [ : ]; do sleep 1; done"
else
    tmux neww -n "$query" bash -c "chatsh -chat-file \"$chatfile\" -prompt \"$prompt\" chat \"$query\" & while [ : ]; do sleep 1; done"
fi

