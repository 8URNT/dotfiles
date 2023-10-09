#!/usr/bin/env bash

# Function to check if volume is currently at 0%
is_volume_zero() {
  local sink_id="$1"
  local volume
  volume=$(wpctl get-volume "$sink_id" | awk -F ' ' '{print $2}')
  [ "$volume" = "0.00" ]
}

# Get the first sink ID
SINK_ID_1=$(wpctl status | grep -A 1 "Sinks:" | awk 'NR==2 {gsub(/[^0-9]/, "", $3); print $3}')

# Get the second sink ID (modify the grep and awk commands as needed)
SINK_ID_2=$(wpctl status | grep -A 2 "Sinks:" | awk 'NR==3 {gsub(/[^0-9]/, "", $2); print $2')

# Check if the first command-line argument is "mute"
if [ "$1" = "mute" ]; then
  # Check if the volume is currently at 0% for Sink 1
  if is_volume_zero "$SINK_ID_1"; then
    wpctl set-volume "$SINK_ID_1" "40%"
  else
    wpctl set-volume "$SINK_ID_1" "0%"
  fi

  # Check if the volume is currently at 0% for Sink 2
  if is_volume_zero "$SINK_ID_2"; then
    wpctl set-volume "$SINK_ID_2" "40%"
  else
    wpctl set-volume "$SINK_ID_2" "0%"
  fi
fi

# Play the popping sound after volume adjustment (or mute/unmute)
paplay ~/.config/hypr/scripts/resource/cowbell_os.mp3
