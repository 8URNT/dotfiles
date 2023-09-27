#!/bin/bash

# Define the brightness scale as integer values
brightness_scale=("0%" "1%" "5%" "10%" "15%" "20%" "25%" "30%" "35%" "40%" "45%" "50%" "55%" "60%" "65%" "70%" "75%" "80%" "85%" "90%" "95%" "100%")

get_current_brightness() {
    current_value=$(brightnessctl g)
    
    # Calculate the percentage based on the max brightness (1388)
    percentage=$((current_value * 100 / 1388))
    
    # Find the nearest value in the scale
    nearest_value="${brightness_scale[0]}"
    
    for scale_value in "${brightness_scale[@]}"; do
        scale_percentage="${scale_value%\%}"
        if [ "$percentage" -le "$scale_percentage" ]; then
            nearest_value="$scale_value"
            break
        fi
    done
    
    echo "$nearest_value"
}

set_brightness() {
    brightnessctl set "$1"
    echo "Screen brightness set to $1"
}

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 [up|down]"
    exit 1
fi

action="$1"

current_brightness=$(get_current_brightness)

current_index=0
for i in "${!brightness_scale[@]}"; do
    if [ "${brightness_scale[$i]}" = "$current_brightness" ]; then
        current_index=$i
        break
    fi
done

if [ "$action" = "up" ]; then
    new_index=$((current_index + 1))
    if [ "$new_index" -lt "${#brightness_scale[@]}" ]; then
        set_brightness "${brightness_scale[$new_index]}"
    else
        echo "Already at maximum brightness."
    fi
elif [ "$action" = "down" ]; then
    new_index=$((current_index - 1))
    if [ "$new_index" -ge 0 ]; then
        set_brightness "${brightness_scale[$new_index]}"
    else
        echo "Already at minimum brightness."
    fi
else
    echo "Invalid argument. Use 'up' or 'down'."
    exit 1
fi
