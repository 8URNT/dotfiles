#!/bin/bash

CONFIG_FILES="$HOME/.config/waybar/config $HOME/.config/waybar/style.css"

trap "killall waybar" EXIT

# Check if inotifywait is available
if command -v inotifywait >/dev/null 2>&1; then
    while true; do
        waybar &
        inotifywait -e create,modify $CONFIG_FILES
        killall waybar
    done
else
    # If inotifywait is not available, simply start waybar
    waybar
fi
