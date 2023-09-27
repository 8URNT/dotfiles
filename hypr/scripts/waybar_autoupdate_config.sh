#!/bin/bash

LOCK_FILE="/tmp/waybar_autoupdate_config.lock"
CONFIG_FILES="$HOME/.config/waybar/config $HOME/.config/waybar/style.css"

# Check if the lock file exists (indicating the script is already running)
if [ -e "$LOCK_FILE" ]; then
    echo "Script is already running. Launching Waybar only."
    waybar
    exit 1
fi

# Create the lock file
touch "$LOCK_FILE"

# Function to remove the lock file on exit
cleanup() {
    rm -f "$LOCK_FILE"
}

trap cleanup EXIT

# Check if inotifywait is available
if command -v inotifywait >/dev/null 2>&1; then
    while true; do
        waybar &
        PID=$!
        inotifywait -e create,modify $CONFIG_FILES
        kill $PID
    done
else
    # If inotifywait is not available, simply start waybar
    waybar
fi
