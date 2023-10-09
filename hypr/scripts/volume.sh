#!/usr/bin/env bash

# Get the first sink ID
SINK_ID_1=$(wpctl status | grep -A 1 "Sinks:" | awk 'NR==2 {gsub(/[^0-9]/, "", $3); print $3}')

# Get the second sink ID (modify the grep and awk commands as needed)
SINK_ID_2=$(wpctl status | grep -A 2 "Sinks:" | awk 'NR==3 {gsub(/[^0-9]/, "", $2); print $2}')

# Check if a positive or negative argument is provided
if [ "$1" -gt 0 ]; then
  wpctl set-volume "$SINK_ID_1" "0.1+"
  wpctl set-volume "$SINK_ID_2" "0.1+"
elif [ "$1" -lt 0 ]; then
  wpctl set-volume "$SINK_ID_1" "0.1-"
  wpctl set-volume "$SINK_ID_2" "0.1-"
fi

# Play the popping sound after volume adjustment
paplay ~/.config/hypr/scripts/resource/cowbell_os.mp3
