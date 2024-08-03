#!/bin/bash

current_layout=$(hyprctl devices -j | jq -r '.keyboards[] | select(.name=="at-translated-set-2-keyboard") | .active_keymap')

if [ "$current_layout" = "French" ]; then
    hyprctl switchxkblayout at-translated-set-2-keyboard 1
else
    hyprctl switchxkblayout at-translated-set-2-keyboard 0
fi
